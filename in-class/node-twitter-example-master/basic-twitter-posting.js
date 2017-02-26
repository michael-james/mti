var Twitter = require('twitter'); // for the Twitter API
var env = require('dotenv').config(); // for loading API credentials


// initialize the twitter client with your keys
var client = new Twitter({
        consumer_key: process.env.TWITTER_CONSUMER_KEY,
        consumer_secret: process.env.TWITTER_CONSUMER_SECRET,
        access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY,
        access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET
});

// post a tweet
client.post('statuses/update', {

        status: 'Hello World!'

}, function(err, tweet, res) {
        if (!err) {
                console.log("You tweeted: " + tweet.text);
        } else {
                console.log(err);
        }
});


