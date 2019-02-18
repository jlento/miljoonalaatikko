const request = require('request')
, jsdom = require('jsdom');

const { JSDOM } = jsdom;

const baseurl = "https://research.csc.fi/";
const bodySelector = process.argv[2];
const url = process.argv[3];

function clean (b) {
    const navElemSelector = "table.form-style";
    const spanElemSelector = "span.link-external";
    b.querySelectorAll(navElemSelector).forEach(function (navElem) {
        navElem.parentNode.removeChild(navElem);
    });
    let spans = b.querySelectorAll(spanElemSelector);
    spans.forEach(function (e) {
        while( e.firstChild ) {
            e.parentNode.insertBefore(e.firstChild, e);
        }
        e.parentNode.removeChild(e);
    });
    b.querySelectorAll("img").forEach(function (img) {
        if (/^data:/.test(img.src)) {
            img.src = "";
        } else if (! /^(https:|http:)/.test(img.src)) {
            img.src = img.src.replace(/^\.?\/?/, baseurl);
        }
    });
    b.querySelectorAll("a").forEach(function (a) {
        if (! /^(#|https:|http:|ftp:|mailto:)/.test(a.href)) {
            a.href = a.href.replace(/^\.?\/?/, baseurl);
        }
    });

}

request(url, function (error, response, content) {
    let dom = new JSDOM(content);
    let body = dom.window.document.querySelector(bodySelector);
    clean(body);
    console.log(body.innerHTML);
});
