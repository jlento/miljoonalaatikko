//grunt task for pandoc
module.exports = function(grunt) {

	  var pkgroot    = grunt.option('pkgroot');
	  var root       = grunt.option('root') || '.';
	  var mdsrc      = grunt.option('mdsrc');
	  var pandocopts = grunt.option('pandocopts');

    grunt.log.writeln(root);

    grunt.config.merge({
        pandoc: {
            src: [ mdsrc ],
            dest: mdsrc.replace(/\.md$/,".html"),
        },
        watch: {
            markdown: {
                files: [ mdsrc ],
                tasks: [ 'pandoc' ],
            }
        }
    });

    grunt.registerTask('pandoc', function() {
        var path    = require('path'),
            exec    = require('child_process').exec,
            child,
            done    = grunt.task.current.async(),
            src     = grunt.config('pandoc.src')[0],
            dest    = grunt.config('pandoc.dest');
        child = exec(
            `cd ${root}; bash ${pkgroot}/bin/mdslides ${src} -o ${dest} ${pandocopts}`,
            function(error, stdout, stderr) {
                done(error);
            }
        );
    });

    grunt.registerTask('serve', [ 'pandoc', 'connect', 'watch']);

};
