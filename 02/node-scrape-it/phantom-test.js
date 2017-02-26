// var phantomjs = require('phantomjs-prebuilt')

// var args = process.argv.slice(2);
// var file = args[0];
// var arg1 = args[1];

// var program = phantomjs.exec('phantom-1.js')
// // var program = phantomjs.exec('phantomwebintro.js')
// // var program = phantomjs.exec('phantom-examples/' + file + '.js', arg1)
// program.stdout.pipe(process.stdout)
// program.stderr.pipe(process.stderr)
// program.on('exit', code => {
//   // do something on end 
// })

// console.log(stdout, stderr);      // Always empty
// var result = JSON.parse(stdout);
// console.log(result);


var path = require('path')
var childProcess = require('child_process')
var phantomjs = require('phantomjs-prebuilt')
var binPath = phantomjs.path
var childArgs = [
  path.join(__dirname, 'phantom-1.js')
]

// console.log(binPath);
// console.log(childArgs);
 
childProcess.execFile(binPath, childArgs, function(err, stdout, stderr) {
  var result = JSON.parse(stdout);
  console.log(result.pandas);
})
 