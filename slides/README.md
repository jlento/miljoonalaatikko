## Slides

Convert markdown* to HTML slide show. Basically just some messy scripts on top
of the great: [Reveal.js](https://github.com/hakimel/reveal.js)
and [Pandoc](http://pandoc.org).

<p style="margin-top: 2em">*<span style="font-size: 75%"> or any other input
format that Pandoc reads, see 'pandoc --list-input-formats'</span></p>


## Alternatives

* [reveal-md](https://github.com/webpro/reveal-md) (very nice, slightly less
  general, more elegant, but bug in pdf export)


## Requires

* Basic use: Bash, Git, Pandoc
* Development: Node.js and npm
* ... and a browser, of course!
* includes reveal.js as a git submodule 


## Simple install

* Install Pandoc
* Clone this repository:
    ```bash
    git clone https://github.com/jlento/miljoonalaatikko.git
    cd miljoonalaatikko/slides
    ```


## Simple usage example

Compile the slides into a single HTML file and open it in a browser:

```bash
./bin/mdslides examples/ex1/README.md --self-contained \
    > examples/ex1/README.html
chromium-browser examples/ex1/README.html &
```


## Advanced / development install

Not much more involved. No fear. Lot's of more features.

Advanced features of reveal.js and the automatic compile and reload of the
slides after markdown source modifications uses Node.js and local HTTP server.

* Install Node.js and npm
* do reveal.js [full-setup](https://github.com/hakimel/reveal.js##full-setup):
    ```bash
    npm --prefix=reveal.js install
    ```


## Advanced / development use

Compile the markdown to HTML, but do not make it self-contained as in basic
usage. Instead, serve the pages dynamically

```bash
./bin/mdslides-serve example/ex1/README.md
```
    

## Source guide

Sixty characters wide **code blocks** should fit without scroll

```bash
123456789 123456789 123456789 123456789 123456789 123456789 
```


## Tuning layout

The layout is controlled with CSS, here the file
`reveal.js/css/themes/source/custom.scss`
