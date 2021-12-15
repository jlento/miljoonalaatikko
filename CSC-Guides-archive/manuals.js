function removeElements (element, selector) {
    Array.prototype.forEach.call(element.querySelectorAll(selector), function( node ) {
        node.parentNode.removeChild(node);
    });
}

function stripLifeRay (doc) {
    let root = doc.querySelector('.journal-content-article');
    removeElements(root, 'table.form-style, div.no-print');
    root.querySelectorAll('img').forEach(i => i.style = 'display: block; margin: auto; width: 90%;');
    return root;
}

function grepChapterHrefs() {
    let hrefs = [];
    document.querySelector('.no-print').querySelectorAll('a').forEach((value, index, obj) => hrefs.push(value.href));
    return hrefs;
}

function isHtml (str) {
    const regex = /^<!DOCTYPE html>/i;
    return regex.test(str);
}

function manual () {
    const head = document.createElement('head');
    const body = document.createElement('body');
    const parser = new DOMParser();
    const hrefs = [location.href].concat(grepChapterHrefs());

    const style = document.createElement('style');
    style.innerHTML = `
        @media screen {
            body {width: 600px; margin: auto;}
        }
        @media print {
            body {margin: 30mm}
        }`;
    head.appendChild(style);

    const chapters = hrefs
        .map(url => fetch(url)
            .then(response => response.text())
            .then(text => isHtml(text) ? stripLifeRay(parser.parseFromString(text, 'text/html').body) : null)
        );
    Promise.all(chapters).then(docs => docs.forEach(n => n ? body.appendChild(n) : null));
    return {head, body};
}

let {head, body} = manual();
document.head.innerHTML = head.innerHTML;
document.body = body;
