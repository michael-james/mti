
var phantomFile = 'scraper-phantom.js';

var path = require('path')
var childProcess = require('child_process')
var phantomjs = require('phantomjs-prebuilt')
var binPath = phantomjs.path
var childArgs = [
  path.join(__dirname, phantomFile)
]

console.log("Creating PhantomJS server...");
 
childProcess.execFile(binPath, childArgs, function(err, stdout, stderr) {
  // var result = JSON.parse(stdout);
  // console.log(result);
  // console.log(result.pandas);
})