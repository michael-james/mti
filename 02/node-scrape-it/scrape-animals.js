const scrapeIt = require("scrape-it");

// // Promise interface
// scrapeIt("http://ionicabizau.net", {
//     title: ".header h1"
//   , desc: ".header h2"
//   , avatar: {
//         selector: ".header img"
//       , attr: "src"
//     }
// }).then(page => {
//     console.log(page);
// });

// Callback interface
scrapeIt("http://www.poodwaddle.com/worldclock/env5/", {
    // Fetch the articles
    pandas: $("#MAIN > b:nth-child(1) > b:nth-child(2) > i:nth-child(10) > .WCsv").text().trim();
    }
}, (err, page) => {
    console.log(err || page);
});