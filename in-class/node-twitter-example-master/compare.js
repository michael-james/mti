var Twitter = require('twitter'); // for the Twitter API
var env = require('dotenv').config(); // for loading API credentials
var moment = require('moment'); // for displaying dates nicely
var fs = require('fs');

var client = new Twitter({
    consumer_key: process.env.TWITTER_CONSUMER_KEY,
    consumer_secret: process.env.TWITTER_CONSUMER_SECRET,
    access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY,
    access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET
});

// slices the arguments passed in via the command line. args[0] is the first argument after the file name.
var args = process.argv.slice(2);

var trm1 = args[0];
var trm2 = args[1];

// set up a stream
var streamer1 = client.stream('statuses/filter', {track: trm1});
var streamer2 = client.stream('statuses/filter', {track: trm2});


console.log(trm1 + ", " + trm2);

var count1 = 0;
var count2 = 0;
// var file = 12;

streamer1.on('data', function(tweet) {
    count1 += 1;
    console.log(trm1 + ": " + count1 + ", " + trm2 + ": " + count2);
    // var string = trm1 + ": " + count1 + ", " + trm2 + ": " + count2 + "     " + tweet.text; 

    // fs.appendFile("test" + file + ".txt", string, function(err) {
    //     if(err) {
    //     return console.log(err);
    // }

    //     // console.log("The file was saved!");
    // }); 
});

streamer2.on('data', function(tweet) {
    count2 += 1;
    console.log(trm1 + ": " + count1 + ", " + trm2 + ": " + count2);
    // var string = trm1 + ": " + count1 + ", " + trm2 + ": " + count2 + "     " + tweet.text; 

    // fs.appendFile("test" + file + ".txt", string, function(err) {
    //     if(err) {
    //         return console.log(err);
    //     }

    //     // console.log("The file was saved!");
    // }); 
});