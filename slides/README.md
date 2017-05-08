# Slides

Convert markdown* to HTML slide show. Basically just some messy scripts on top of the great: [Reveal.js](https://github.com/hakimel/reveal.js) and [Pandoc](http://pandoc.org).

<p style="margin-top: 2em">*<span style="font-size: 75%"> or any other input format that Pandoc reads, see 'pandoc --list-input-formats'</span></p>


## Alternatives

* [reveal-md](https://github.com/webpro/reveal-md) (very nice, slightly less general, more elegant, but bug in pdf export)


## Requires

* Basic use: Bash, Git, Pandoc
* Development: Node.js, Grunt, npm
* ... and a browser, of course!
* includes reveal.js as a git submodule 

## Simple install

Install pandoc, clone this repository:

```bash
git clone https://github.com/jlento/miljoonalaatikko.git
cd miljoonalaatikko/slides
```


## Simple usage example

Compile the slides into a single HTML file and open it in a browser:

```bash
./bin/mdslides.bash examples/ex1/README.md --self-contained -o examples/ex1/README.html
chromium-browser examples/ex1/README.html &
```


## Advanced / development install

Advanced features of reveal.js and the automatic compile and reload of the slides after markdown source modifications uses Node.js and local HTTP server.

* Install Node.js, Grunt and npm

* do reveal.js [full-setup](https://github.com/hakimel/reveal.js#full-setup):

```bash
npm --prefix=reveal.js install
```


## Advanced / development use

Compile the markdown to HTML, but do not make it self-contained as in basic usage. Instead, serve the pages dynamically

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
`reveal.js/css/themes/source/custom.scss`.

TODO: If this is moved to

## How this was bootstrapped (OUTDATED!)

Got CSC's official PowerPoint template `Presentation-CSC-PPT-template-2016.potx`
and unpacked it

```bash
mkdir Presentation-CSC-PPT-template-2016
( cd $_ ; unzip ../Presentation-CSC-PPT-template-2016.potx )
```


------------------------------------------


Copied the images from the CSC template to the repo 

```bash
mkdir -p img/csc
cp ../CSCTemplate/Presentation-CSC-PPT-template-2016/ppt/media/*.jpg img/csc/
```


------------------------------------------


Reveal.js stuff, packages npm, nodejs-dev, nodejs-legacy, python-pip

```bash
npm install
sudo npm install -g grunt-cli
cp css/theme/source/white.scss css/theme/source/csc.scss
grunt css-themes
pip install pandocfilters
```

Wrote md2slides.bash, CSC-README.md, templates/csc-template.html
