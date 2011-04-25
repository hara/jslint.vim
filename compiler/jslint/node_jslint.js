/*jslint white: true, devel: true, onevar: true, undef: true, node: true, nomen: true, regexp: true, plusplus: true, bitwise: true, newcap: true, maxerr: 50, indent: 4 */
/*global require, process*/
(function (global) {
    var fs = require('fs'),
        JSLINT = require('./jslint');

    fs.readFile(process.argv[2], 'utf-8', function (err, data) {
        var result,
            i,
            max,
            error,
            message;

        if (err) {
            throw err;
        }

        result = JSLINT(data);
        if (!result) {
            max = JSLINT.errors.length;
            for (i = 0; i < max; i += 1) {
                error = JSLINT.errors[i];
                message = [
                    process.argv[2],
                    error.line,
                    error.character,
                    error.reason
                ].join(':');
                console.log(message);
            }
        }
    });
}(this));
