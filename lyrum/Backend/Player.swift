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
                    "uris":[song.uri],
                ]
                
                print(parameters)
                
                print("About to make request...")
                
                AF.request("https://api.spotify.com/v1/me/player/play", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//                    print(response.result)
//                    print(response.value)
                    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                    print("RESULT:")
                    print(response)
                    print(response.value)
                }
            }
        }
    }
}
