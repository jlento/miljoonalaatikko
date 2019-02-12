const request = require('request')
, fs = require('fs')
, turndown = require('turndown')
, prettify = require('prettify-markdown')
, jsdom = require('jsdom');

const { JSDOM } = jsdom;

const turndownService = new turndown({headingStyle: 'atx'})
      .addRule('codeblocks', {
          filter: ['pre', 'code'],
          replacement: function (content) {
              return content.replace(/^/gm, "    ");
          }
      });

function markdownify(url) {
    const page = url.replace(/.*\//,"").replace(/\?.*/,"");
    request(url, function (error, response, content) {
        if (!error) {
            const dom = new JSDOM(content);
            const body = dom.window.document
                  .querySelector(".journal-content-article");
            if(body) {
                const markdown = turndownService.turndown(body);
                fs.writeFileSync(`${page}.md`, prettify(markdown), 'utf-8');
            } else {
                console.log('Probably not a software page: ' + url);
            }
        }
    });
}

function scrape(url) {
    request(url, function (error, response, content) {
        const dom = new JSDOM(content);
        dom.window.document.querySelectorAll(".portlet-body table a")
            .forEach(v => {
                markdownify(v.href);
            });
    });
}

// Main

[
    'https://research.csc.fi/software-details',

    'https://research.csc.fi/software-details?p_p_id=101_INSTANCE_bwNv9EAV4eYX&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-2&p_p_col_count=1&_101_INSTANCE_bwNv9EAV4eYX_delta=100&_101_INSTANCE_bwNv9EAV4eYX_keywords=&_101_INSTANCE_bwNv9EAV4eYX_advancedSearch=false&_101_INSTANCE_bwNv9EAV4eYX_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_bwNv9EAV4eYX_cur=2'

].forEach(url => scrape(url));
