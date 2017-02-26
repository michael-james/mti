var express = require('express');
var fs      = require('fs');
var request = require('request');
var cheerio = require('cheerio');
var app     = express();

app.get('/scrape', function(req, res){
  // Let's scrape Endangered Species
  url = 'http://www.poodwaddle.com/worldclock/env5/';

  request(url, function(error, response, html){
    if(!error){
      var $ = cheerio.load(html);

      // var title, release, rating;
      var pandas;
      console.log($);
      var json = { pandas : "" };

      $('.WCsl').filter(function(){
        var data = $(this);
        pandas = data.text().trim();
        console.log("pandas: " + pandas);

        json.pandas = pandas;
      })

      // $('.title_wrapper').filter(function(){
      //   var data = $(this);
      //   title = data.children().first().text().trim();
      //   release = data.children().last().children().last().text().trim();

      //   json.title = title;
      //   json.release = release;
      // })

      // $('.ratingValue').filter(function(){
      //   var data = $(this);
      //   rating = data.text().trim();

      //   json.rating = rating;
      // })
    }

    fs.writeFile('output.json', JSON.stringify(json, null, 4), function(err){
      console.log('File successfully written! - Check your project directory for the output.json file');
    })

    res.send('Check your console!')
  })
})

app.listen('8081')
console.log('Magic happens on port 8081');
exports = module.exports = app;