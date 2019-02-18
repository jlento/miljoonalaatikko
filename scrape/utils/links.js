const request = require('request')
, jsdom = require('jsdom');

const { JSDOM } = jsdom;

const linkSelector = process.argv[2];
const url = process.argv[3];

request(url, function (error, response, content) {
    let dom = new JSDOM(content);
    let links = dom.window.document
        .querySelectorAll(linkSelector);
    links.forEach(function (v) {
        console.log(v.href.replace(/\?.*/,""));
    });
});

