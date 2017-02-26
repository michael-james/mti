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

// Promise interface
scrapeIt("http://www.poodwaddle.com/worldclock/env5/", {
    pandas: ".WCsv"
    , content: {
        selector: ".WCsv"
        , how: "html"
      }
}).then(page => {
    console.log(page);
});


// // Promise interface
// scrapeIt("https://www.w3schools.com/html/html_examples.asp", {
//     test: "a"
//     , content: {
//         selector: "h1"
//         , how: "html"
//       }
// }).then(page => {
//     console.log(page);
// });

// Promise interface
// scrapeIt("https://michaeljames.design/", {
//     content: {
//       selector: "h1"
//       , how: "html"
//     }
// }).then(page => {
//     console.log(page);
// });

// // Promise interface
// scrapeIt("http://www.imdb.com/title/tt5052524/", {
//     summary: ".summary_text"
// }).then(page => {
//     console.log(page);
// });


// Callback interface
// scrapeIt("http://ionicabizau.net", {
//     // Fetch the articles
//     articles: {
//         listItem: ".article"
//       , data: {

//             // Get the article date and convert it into a Date object
//             createdAt: {
//                 selector: ".date"
//               , convert: x => new Date(x)
//             }

//             // Get the title
//           , title: "a.article-title"

//             // Nested list
//           , tags: {
//                 listItem: ".tags > span"
//             }

//             // Get the content
//           , content: {
//                 selector: ".article-content"
//               , how: "html"
//             }
//         }
//     }

//     // Fetch the blog pages
//   , pages: {
//         listItem: "li.page"
//       , name: "pages"
//       , data: {
//             title: "a"
//           , url: {
//                 selector: "a"
//               , attr: "href"
//             }
//         }
//     }

//     // Fetch some other data from the page
//   , title: ".header h1"
//   , desc: ".header h2"
//   , avatar: {
//         selector: ".header img"
//       , attr: "src"
//     }
// }, (err, page) => {
//     console.log(err || page);
// });