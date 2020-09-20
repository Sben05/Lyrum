const express = require('express')
const app = express();
//"BQAk6P9MSJ45owcNVqeIfdRj9KGRvNOummFblWBEYAVZX49Ew30aT2c89utCrJCX1juYrAPeA7w1r751p6bMH6Fxwa4nJZ2gFhH2ThsF2VC2Sk-xKw4LdZ0bQB13b2csqAmJxGRI4WGtLjWXR8yGesgQmuH6rGDt"
const cors = require("cors");
//var compression = require('compression');
//app.use(compression());
app.use(express.static('public'));
app.use(cors({credentials: true}));
class User {
    constructor(authKey) {
      this.authKey = authKey;
      
      this.SpotifyWebApi = require('spotify-web-api-node');
      this.spotifyApi = new this.SpotifyWebApi({
        clientId: 'fcecfc72172e4cd267473117a17cbd4d',
        clientSecret: 'a6338157c9bb5ac9c71924cb2940e1a7',
        redirectUri: 'http://www.example.com/callback'
      });
      this.spotifyApi.setAccessToken(this.authKey);
    }
    getTracks(track,cb){
        this.spotifyApi.searchTracks(track)
        .then(function(data) {
            console.log(data.body["tracks"]["items"])
         
        cb(data.body["tracks"]["items"])
        //console.log("####################s")
       /*
            for( var i in data.body["tracks"]["items"][0]){
                var array=[]
                
                if (["album"].includes(i)){
                    array.push(data.body["tracks"]["items"][0][i]["name"])
                   /console.log(data.body["tracks"]["items"][0][i]["name"])
                }
                else if(["name", "artists" , "images"].includes(i)){
                    array.push(data.body["tracks"]["items"][0][i])
                    console.log(data.body["tracks"]["items"][0][i])
                }
                else if(["uri"].includes(i)){
                    console.log(superarray)
                superarray.push(array)
                array=[]
                }
        
            }
           */
          
      
        }, function(err) {
          console.error(err);
        })
    }
  getTopArtists(type, cb){
        var request = require('request');

        var headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer '+ this.authKey,
        };
        
        var options = {
            url: 'https://api.spotify.com/v1/me/top/'+type+"?limit=6",
            headers: headers
        };
        
        function callback(error, response, body) {
            if (!error && response.statusCode == 200) {
                console.log(body);
                cb(body)
            }
        }
        
        request(options, callback);
        
      }
  getMe(cb){
        this.spotifyApi.getMe()
        .then(function(data) {
          console.log('Some information about the authenticated user', data.body);
            cb(data.body)
        }, function(err) {
          console.log('Something went wrong!', err);
        });

    }
  }
var Users = new Object()
app.get("/createuser" , (req,res)=>{
    userid = req.query.id;
    Users[userid] = new User(userid)
    res.send("Created User");
    
})
app.get('/', (req, res) => {
  res.send('Hello World!')
});
app.get("/gettrack" , (req,res)=>{
id = req.query.id    
Users[id] = new User(id)
trackname=req.query.track
    try{
    Users[id].getTracks(trackname, (output)=>{
res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(output));
//res.send(output)
});
    }
    catch(error){
console.log(error)
    }
    
})

app.listen(8000, () => {
  console.log('Example app listening on port 8000!')
});



// credentials are optional


// Get Elvis' albums


app.get('/', (req, res) => {
    res.send('Hello World!')
  });
  class SpotifyConstants {
      constructor(){
      this.CLIENT_ID = "bcac94c5e73345bd9e108357d7680a42"
      this.CLIENT_SECRET = "49da45b67bf342aa828dcc189d67c036" // NEED TO MOVE THIS TO A SERVER REQ
      this.SCOPE= "user-read-email user-modify-playback-state user-top-read"
      this.REDIRECT_URI="spotify-ios-quick-start://spotify-login-callback"
      this.CODE = ""
      this.ACCESS_TOKEN = ""

      }
      makerefreshtoken(codee, cb){
        const request = require('request');

        const options = {
            method: 'POST',
            url: 'https://accounts.spotify.com/api/token',
            json: true,
            form: {
                client_id: this.CLIENT_ID,
                code: codee,
                scope: this.SCOPE,
                grant_type:"authorization_code",
                redirect_uri:this.REDIRECT_URI,
                client_secret:this.CLIENT_SECRET,
            },
          //  headers: {
           //     'Content-Type': 'application/x-www-form-urlencoded',

            //}
        };
        
        request.post(options, (err, res, body) => {
            if (err) {
                return console.log(err);
            }
            console.log(res.body)
            console.log(`Status: ${res.statusCode}`);
            console.log(body);
            cb(body)
        });

      }
makerefreshtokenfromrefresh(codee, cb){
        const request = require('request');
       
        const options = {
            method: 'POST',
            url: 'https://accounts.spotify.com/api/token',
            json: true,
            form: {
               
            
                grant_type:"refresh_token",
                refresh_token:codee,
                scope: this.SCOPE,
                
            },
           headers: {
               Authorization: "Basic YmNhYzk0YzVlNzMzNDViZDllMTA4MzU3ZDc2ODBhNDI6NDlkYTQ1YjY3YmYzNDJhYTgyOGRjYzE4OWQ2N2MwMzY="
           //     'Content-Type': 'application/x-www-form-urlencoded',

            }
        };
        
        request.post(options, (err, res, body) => {
            if (err) {
                return console.log(err);
            }
            console.log(res.body)
            console.log(`Status: ${res.statusCode}`);
            console.log(body);
            cb(body)
        });

      }
}
app.get('/refreshtoken', (req, res) => {
    code = req.query.code
    console.log(typeof(code))
    new SpotifyConstants().makerefreshtoken(code,(output)=>{res.send(output)})
    
  });

app.get('/accessusingrefresh', (req, res) => {
    code = req.query.code
    console.log(typeof(code))
    new SpotifyConstants().makerefreshtokenfromrefresh(code,(output)=>{res.send(output)})
    
  });
app.get("/me" , (req,res)=>{
id = req.query.id
Users[id] = new User(id)
Users[id].getMe((output)=>{res.send(output)})

});

app.get("/top" , (req,res)=>{
id = req.query.id
type= req.query.type
Users[id]=new User(id)
Users[id].getTopArtists(type, (output)=>{res.send(output)})
});
