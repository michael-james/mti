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
                // method 1
                var selector = "#stat380";
                var element = $(selector).text();
                // console.log(element);

                jsonObj = [];
                var selector = ".WCs5";

                // method 2
                $(selector).each(function() {
                    var animal = $(this).find(".WCsl").text().replace(/[^\w\s]/gi, '').replace(/\s/g,'');
                    var count = $(this).find(".WCsv").text();

                    item = {}
                    item [animal] = count;
                    // console.log(item);

                    jsonObj.push(item);
                });

                // console.log(jsonObj);
                // jsonString = JSON.stringify(jsonObj);
                console.log(JSON.stringify({x: 19, y: 15}));
            });
            phantom.exit(0);
        });
    } else {
        phantom.exit(1);
    }
});



