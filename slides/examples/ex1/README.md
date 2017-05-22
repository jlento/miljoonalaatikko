---
title: Markdown slides with Pandoc and Reveal JS
author: Juha Lento
date: 22 May 2017
---


## Overview

Pandoc translates markdown to HTML Reveal JS slides, which can be
viewed in a browser.


## Requires

* Basic use: Bash, Git, Pandoc
* Development: Node.js and npm
* ... and a browser, of course!
 

## Install

Install pandoc, clone this repository:

```bash
$ git clone https://github.com/jlento/miljoonalaatikko.git
Cloning into ...
$ cd miljoonalaatikko/slides
```


## Basic usage

Compile the slides into a single HTML file and open it in a browser:

```bash
$ ./md2slides.bash --self-contained README.md > index.html
$ chromium-browser index.html &
```


## Advanced use / development

* Install Node.js, Grunt and npm
* Compile the markdown to HTML, but do not make it self-contained as in basic usage
    ```bash
    $ ./md2slides.bash README.md > index.html
    ```
* Start a local HTTP server (note root directory!) and open slides in a browser
    ```bash
    $ ( cd reveal.js && npm install && npm start -- --root=.. ) &
    $ chromium-browser http://localhost:8000 &
    ```
    

## Source guide

Sixty characters wide **code blocks** should fit without scroll

```bash
123456789 123456789 123456789 123456789 123456789 123456789 
```


## "Enriching" content

Content can be easily enriched at Pandoc's markdown to HTML transform stage. One
can manipulate Pandoc's AST with filters, or inject HTML and JavaScript through
Pandoc's command line options. Here I've chosen the latter alternative, see
`md2slides.bash`.


## Tuning layout

The layout is controlled with CSS, here the file
`reveal.js/css/themes/source/custom.scss`.


## Printing PDF handouts

PDF printing works as in Reveal.js,
see <https://github.com/hakimel/reveal.js#pdf-export>, i.e. add `?print-pdf` to
the page URL in the Chrome browser and print from the browser.

## Implementation details

Both Pandoc and slideshow HTTP server need access to auxiliary files from
package root directory. It is simplest to just create a soft link so everything
seems to be in the same directory as the markdown source.
