function tag_input() {
    var cmdline=/(^|\n)(\$)([^\n]*)/g;
    [].forEach.call(document.querySelectorAll( "code.sourceCode.bash" ),
                    function (e) {
                        e.innerHTML = e
                            .innerHTML
                            .replace(cmdline, "$1<span class=\"prompt\">$2</span><strong>$3</strong>");
                    });
}
tag_input();
