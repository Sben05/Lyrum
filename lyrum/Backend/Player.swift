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
        SpotifyAPI.access_token { (success) in
            if !success {
                // pass
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
                                            
                AF.request("https://api.spotify.com/v1/me/player/play", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    // yas
                }
            }
        }
    }
}
