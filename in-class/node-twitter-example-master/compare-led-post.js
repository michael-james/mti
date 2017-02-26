var Twitter = require('twitter'); // for the Twitter API
var env = require('dotenv').config(); // for loading API credentials
var moment = require('moment'); // for displaying dates nicely
var fs = require('fs');
var GPIO = require('onoff').Gpio; // for GPIO pin control

// define the pins
var led1 = new GPIO(17, 'out');
var led2 = new GPIO(27, 'out');

var dly = 30;

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

var timerStart = Date.now();

// set up a stream
var streamer1 = client.stream('statuses/filter', {track: trm1});
var streamer2 = client.stream('statuses/filter', {track: trm2});


console.log(trm1 + ", " + trm2);

var count1 = 0;
var count2 = 0;
var rate1 = 0;
var rate2 = 0;

streamer1.on('data', function(tweet) {
    count1 += 1;
    flash(led1);
    calculate();
});

streamer2.on('data', function(tweet) {
    count2 += 1;
    flash(led2);
    calculate();
});

function calculate() {
    var now = Date.now();
    var diff = now - timerStart;
    var diffSec = diff / 1000.0;
    rate1 = Math.round((count1 / diffSec) * 100) / 100;
    rate2 = Math.round((count2 / diffSec) * 100) / 100;
    console.log(trm1 + ": " + count1 + ", " + trm1 + "/sec: " + rate1 + "; " + trm2 + ": " + count2 + ", " + trm2 + "/sec: " + rate2);
}

function flash(LEDid) {
    LEDid.writeSync(1);

    setTimeout(function() {
            LEDid.writeSync(0);
        }, dly);
}

// gracefully shut down the pins on quit
process.on('SIGINT', function() {
        led1.unexport();
        led2.unexport();

        // post a tweet
    client.post('statuses/update', {

        status: trm1 + '/sec: ' + rate1 + '; ' + trm2 + '/sec: ' + rate2 

        }, function(err, tweet, res) {
        if (!err) {
                console.log("You tweeted: " + tweet.text);
        } else {
                console.log(err);
        }
    });
})