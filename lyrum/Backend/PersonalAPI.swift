//
//  PersonalAPI.swift
//  lyrum
//
//  Created by Josh Arnold on 9/20/20.
//

import Alamofire

//


func request_fav_artist(completion: @escaping (_ result:[String]) -> ()) {
    
    print("\n\n\n")
    print("Req artists")
    
    var result:[String] = []
    
    SpotifyAPI.access_token { (done) in
        if !done {
            return
        }
        
        let url = "http://ec2-18-219-166-211.us-east-2.compute.amazonaws.com:8000/top?type=artists&id=" + SpotifyConstants.ACCESS_TOKEN
        
        let req = AF.request(url, method: .get)
        
        req.responseJSON { (data) in
            if data.error == nil {
                if let res = data.value as? [String:Any] {
                    for i in res["items"] as! [[String:Any]] {
                        let image = i["images"] as! [Any]
                        
                        let finalImage = image[1] as! [String:Any]
                        
                        let url = finalImage["url"] as! String
                        
                        result.append(url)
                    }
                }
                
                completion(result)
            }
            
            
        }
    }
}



func request_fav_songs(completion: @escaping (_ result:[Song]) -> ()) {
    
    print("\n\n\n")
    print("Req songs")
    
    var result:[Song] = []
    
    SpotifyAPI.access_token { (done) in
        if !done {
            return
        }
        
        let url = "http://ec2-18-219-166-211.us-east-2.compute.amazonaws.com:8000/top?type=tracks&id=" + SpotifyConstants.ACCESS_TOKEN
        
        let req = AF.request(url, method: .get)
        
        req.responseJSON { (data) in
            if data.error == nil {
                if let res = data.value as? [String:Any] {
                    for i in res["items"] as! [[String:Any]] {
                       
                        let song = Song()
                        song.title = i["name"] as! String
                        
                        song.artwork = ((i["album"] as! [String:Any])["images"] as! [[String:Any]])[1]["url"] as! String
                        
                        song.artist = "XYZ"
                        
                        result.append(song)
                    }
                }
                completion(result)
            }
        }
    }
}
