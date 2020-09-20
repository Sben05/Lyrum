//  songSearch
//
//  Created by Shreeniket Bendre on 9/19/20.
//  Copyright © 2020 Shreeniket Bendre. All rights reserved.
//

import Alamofire


class Song {
    var id:String = ""
    var title:String = ""
    var artwork:String = ""
    var artist:String = ""
    var preview:String = ""
    var uri:String = ""
}


class Search {
    static func song(text:String, limit:Int = 10, offset:Int = 0, completion: @escaping (_ success:Bool, _ results:[Song]) -> ()) {
        
        SpotifyAPI.access_token { (success) in
            if !success {
                completion(false, [])
            }else{
                let access_token:String = SpotifyConstants.ACCESS_TOKEN
                
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer " + access_token,
                    "Accept": "application/json"
                ]
                
                let parameters: [String: Any] = [
                    "q": "\(text)",
                    "type": "track",
                    "market": "US",
                    "limit": "\(limit)",
                    "offset": "\(offset)",
                ]
                
                var result:[Song] = []
                
                AF.request("https://api.spotify.com/v1/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
                    
                    // Cast result to dictionary
                    if let res = response.value as? [String:Any] {
                        if let res = res["tracks"] as? [String:Any] {
                            if (res["total"] as! Int != 0){
                                let myArr: NSArray = res["items"] as! NSArray
                                var count = 0
                                while(count < limit){
                                    let myDictionary: NSDictionary = myArr[count] as! NSDictionary
                                    let artist:NSArray = ((myDictionary["album"]as!NSDictionary)["artists"]as!NSArray)
                                    let dictArtist = artist[0] as! NSDictionary
                                    let artistURL = (dictArtist["external_urls"] as! NSDictionary)["spotify"]!
                                    let artistID = dictArtist["id"]!
                                    let artistName = dictArtist["name"]!
                                    let image:NSArray = ((myDictionary["album"]as!NSDictionary)["images"]as!NSArray)
                                    let dictImage = image[1] as! NSDictionary
                                    let imageURL = dictImage["url"]!
                                    let explicitInt = myDictionary["explicit"]
                                    var explicit: Bool = false
                                    if (explicitInt as! Int == 1) {
                                        explicit = true
                                    }
                                    let duration:Double = ((myDictionary["duration_ms"] as! Double)/1000)
                                    let songName = myDictionary["name"]!
                                    let id = myDictionary["id"]!
                                    var previewURL = myDictionary["preview_url"]!
                                    let previewURLString:String = "\(previewURL)"
                                    if (previewURLString == "<null>"){
                                        previewURL = "No preview"
                                    }
                                    let uri = myDictionary["uri"]!
                        
                                    let song = Song()
                                    song.id = id as! String
                                    song.title = songName as! String
                                    song.artwork = imageURL as! String
                                    song.artist = artistName as! String
                                    song.preview = previewURLString
                                    song.uri = uri as! String
                                    result.append(song)
                                    
                                    count+=1
                                }
                                
                                // Done
                                completion(true, result)
                                
                            }else{
                                completion(false, [])
                            }
                        }
                    }
                }
            }
        }
        
    }
}
