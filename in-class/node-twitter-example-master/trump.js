var Twitter = require('twitter'); // for the Twitter API
var env = require('dotenv').config(); // for loading API credentials
var moment = require('moment'); // for displaying dates nicely
var GPIO = require('onoff').Gpio; // for GPIO pin control

// define the pins
var led = new GPIO(17, 'out');

var client = new Twitter({
    consumer_key: process.env.TWITTER_CONSUMER_KEY,
    consumer_secret: process.env.TWITTER_CONSUMER_SECRET,
    access_token_key: process.env.TWITTER_ACCESS_TOKEN_KEY,
    access_token_secret: process.env.TWITTER_ACCESS_TOKEN_SECRET
});

// set up a stream
var args = process.argv.slice(2);

// set up a stream
var streamer = client.stream('statuses/filter', {track: args[0]});


streamer.on('data', function(tweet) {

	if (tweet.user != null) {
        led.writeSync(1);
		var name = tweet.user.screen_name;
    	var text = tweet.text;
    	var date = moment(tweet.created_at, "ddd MMM DD HH:mm:ss Z YYYY");

    	console.log(">    @" + name + " said: " + text + ", on " + date.format("YYYY-MM-DD") + " at " + date.format("h:mma"));

        setTimeout(function() {
            led.writeSync(0);
        }, 50);
	}    

});