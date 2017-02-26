const scrapeIt = require("scrape-it");

// Promise interface
scrapeIt("http://www.poodwaddle.com/worldclock/env5/", {
    pandas: "#MAIN > b:nth-child(1) > b:nth-child(2) > i:nth-child(10) > .WCsv"
}).then(page => {
    console.log(page);
});

// Callback interface
scrapeIt("http://www.poodwaddle.com/worldclock/env5/", {
    // Fetch the articles
    pandas: "#MAIN > b:nth-child(1) > b:nth-child(2) > i:nth-child(10) > .WCsv"
}, (err, page) => {
    console.log(err || page);
});