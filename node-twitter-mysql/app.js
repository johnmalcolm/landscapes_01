var Twitter = require('twitter');
var dateFormat = require('dateformat');
var emojiStrip = require('emoji-strip');
const fs = require('fs');
const csv = require('csv-parser');
var mysql = require('mysql');

var client = new Twitter({
  consumer_key: process.env.TWITTER_API_KEY,
  consumer_secret: process.env.TWITTER_TOKEN_KEY,
  access_token_key: process.env.TWITTER_TOKEN_SECRET,
  access_token_secret: process.env.TWITTER_API_SECRET
});

var connection = mysql.createConnection({
  host     : 'mutualcollective.crjhyx0oh3pw.us-east-2.rds.amazonaws.com',
  user     : 'mutualcollective',
  password : process.env.MYSQL_PASSWORD,
  database : 'L01_localelection'
});
 
connection.connect();
 
fs.createReadStream('/Users/johnmalcolm/dev/queerdiaspora/fresh.csv')
.pipe(csv())
.on('data', function(data){
    try {
        console.log(data.name);
        connection.query('INSERT INTO tweets_preagg( \
          party, \
          constituency, \
          counciller, \
          name, \
          user_id, \
          screen_name, \
          created_date, \
          created_time, \
          tweet_id, \
          tweet_text, \
          in_reply_to_status_id, \
          retweet_count, \
          favorite_count, \
          favorited, \
          retweeted) \
          VALUES ("'+data.party+'", \
                  "'+data.constituency+'", \
                  '+data.counciller+', \
                  "'+data.name+'", \
                  '+data.counciller+', \
                  "'+data.user_id+'", \
                  "'+data.created_date+'", \
                  "'+data.created_time+'", \
                  '+data.tweet_id+', \
                  "'+data.tweet_text+'", \
                  '+data.in_reply_to_status_id+', \
                  '+data.retweet_count+', \
                  '+data.favorite_count+', \
                  '+data.favorited+', \
                  '+data.retweeted+' \
                  ) \
          ;', function (error, results, fields) {
          if (error) throw error;
          console.log(results);
        });
     }
    catch(err) {
        //error handler
    }
})
.on('end',function(){
    //some final operation
    connection.end();
}); 

// fs.createReadStream('/Users/johnmalcolm/dev/queerdiaspora/mgmt_02.csv')
// .pipe(csv())
// .on('data', function(data){
//     try {
//         console.log(data.name);
//         var params = {screen_name: 'nodejs'};
//         // add since_id for future pulls as per https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline.html
//         client.get('statuses/user_timeline', {screen_name:data.screen_name, count:200}, function(error, tweets, response) {
//           if (!error) {
//             tweets.forEach(function(entry){
//               cllr = 0;
//               if (data.cllr == 'yes') {
//                 cllr = 1
//               }
//             if (entry.text){
//               fs.appendFile('/Users/johnmalcolm/dev/queerdiaspora/fresh.csv', 
//                                             data.party  +"," +  
//                                             data.constituency +"," + 
//                                             cllr +"," + 
//                                             data.name +"," + 
//                                             entry.user.id + "," +  
//                                             entry.user.screen_name + "," + 
//                                             dateFormat(entry.created_at, "isoDate") + "," + 
//                                             dateFormat(entry.created_at, "isoTime") + "," + 
//                                             entry.id + "," + 
//                                             entry.text.replace(/\t/g," ").replace(/\n/g," ").replace(/"/g," ").replace(/'/g," ").replace(/\t/g," ").replace(/,/g," ").replace(/‘/g," ") + ", " + 
//                                             entry.in_reply_to_status_id  + "," + 
//                                             entry.retweet_count + "," + 
//                                             entry.favorite_count  + "," + 
//                                             entry.favorited  + "," +  
//                                             entry.retweeted + "\n", 
//                                   function (err) {
//                           if (err) {
//                             console.log(err)
//                           }
//                 })
//               }
//             })
//           }
//         })
//     }
//     catch(err) {
//         //error handler
//     }
// })
// .on('end',function(){
//     //some final operation
// }); 
 
// var params = {screen_name: 'nodejs'};

// // add since_id for future pulls as per https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline.html
// client.get('statuses/user_timeline', {screen_name:'BeckhaDSocDems', count:200}, function(error, tweets, response) {
//   if (!error) {
//     tweets.forEach(function(entry){
//     if (entry.text){
//         fs.appendFile('message.txt', dateFormat(entry.created_at, "isoDate") + "\t " + dateFormat(entry.created_at, "isoTime") +"\t " + entry.id + "\t " + entry.user.id + "\t " +  entry.user.screen_name + "\t " 
//           + emojiStrip(entry.text.replace(/\t/g," ").replace(/\n/g," ")) + "\t " + entry.in_reply_to_status_id  + "\t " 
//           + entry.retweet_count + "\t " + entry.favorite_count  + "\t " + entry.favorited  + "\t " +  entry.retweeted + "\n", function (err) {
//             if (err) {
//               console.log(err)
//             }
//           })
//       }
//     })
//   }
// })