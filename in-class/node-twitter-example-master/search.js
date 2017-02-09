var Twitter = require('twitter'); // for the Twitter API
var env = require('dotenv').config(); // for loading API credentials
var moment = require('moment'); // for displaying dates nicely

var client = new Twitter({
    consumer_key: process.env.TWITTER_CONSUMER_KEY,
    consumer_secret: process.env.TWITTER_CONSUMER_SECRET,
    access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY,
    access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET
});

// slices the arguments passed in via the command line. args[0] is the first argument after the file name.
var args = process.argv.slice(2);

client.get('search/tweets', {
    q: args[0],
    lang: "en",
    count: args[1]
}, function(error, tweets, response) {

    tweets.statuses.forEach(function(tweet) {

        var name = tweet.user.screen_name;
        var text = tweet.text;
        var date = moment(tweet.created_at, "ddd MMM DD HH:mm:ss Z YYYY");

        console.log("@" + name + " said: " + text + ", on " + date.format("YYYY-MM-DD") + " at " + date.format("h:mma"));
    })
});