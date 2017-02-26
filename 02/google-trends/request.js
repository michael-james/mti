const googleTrends = require('google-trends-api');

googleTrends.interestOverTime({keyword: 'Valentines Day'})
.then(function(results){
  console.log(results);
})
.catch(function(err){
  console.error(err);
});