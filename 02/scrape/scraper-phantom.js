// Read the Phantom webpage '#intro' element text using jQuery and "includeJs"

"use strict";
var system = require('system');
var page = require('webpage').create();


page.onConsoleMessage = function(msg) {
    console.log(msg);
};

var site = "http://www.poodwaddle.com/worldclock/env5/";

page.open(site, function(status) {
    if (status === "success") {
        console.log("Finding number of pandas left...");
        page.includeJs("http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js", function() {
            page.evaluate(function() {
                var selector = "#stat380";
                var element = $(selector).text();
                console.log(element);
                // console.log(JSON.stringify({pandas: element}));
            });
            phantom.exit(0);
        });
    } else {
        phantom.exit(1);
    }
});