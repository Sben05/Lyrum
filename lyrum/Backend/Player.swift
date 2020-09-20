//
//  Player.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import Alamofire


class SpotifyPlayer {
    
    static func playSong(song:Song) {
        
        print("Trying to req access token")

        SpotifyAPI.access_token { (success) in
            
            print(UIDevice.current.identifierForVendor?.uuidString)
            
            
            
            if !success {
                // passs
                print("FAILED TO GET REQ ACCESS TOKEN")
            }else if let uuid = UIDevice.current.identifierForVendor?.uuidString {
                
                let access_token:String = SpotifyConstants.ACCESS_TOKEN
                
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer " + access_token,
                    "Accept": "application/json"
                ]
                
                let parameters: [String: Any] = [
                    "device_id": uuid,
                    "context_uri":song.uri,
                    "position_ms": 0,
                ]
                
                print("About to make request...")
                
                AF.request("https://api.spotify.com/v1/me/player/play", method: .put, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
//                    print(response.result)
//                    print(response.value)
                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                    print("RESULT:")
                    print(response.value)
                    print(response.error?.localizedDescription)
                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                }
            }
        }
    }
}
