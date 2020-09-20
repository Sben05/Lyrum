//
//  Database.swift
//  lyrum
//
//  Created by Josh Arnold on 9/18/20.
//

import Parse
import SVProgressHUD


func does_user_exist(user_id:String, completion: @escaping (_ exists:Bool) -> ()) {
    let query = PFQuery(className: PFUser().parseClassName)
    query.whereKey("username", equalTo: user_id)
    query.getFirstObjectInBackground { (obj, error) in
        if error == nil {
            completion(true)
        }else{
            completion(false)
        }
    }    
}


func sign_up_user(user_id:String, completion: @escaping (_ success:Bool) -> ()) {
    let user = PFUser()
    user.username = user_id
    user.password = user_id
    
    user.signUpInBackground { (success, error) in
        completion(success)
    }
}


func login_user(user_id:String, completion: @escaping (_ success:Bool) -> ()) {
    guard PFUser.current() == nil else {
        completion(true)
        return
    }
    PFUser.logInWithUsername(inBackground: user_id, password: user_id) { (user, error) in
        if error == nil {
            completion(true)
        }else{
            completion(false)
        }
    }
}


func create_post(song_title:String, song_id:String, artist:String, user:PFUser, preview_link:String, stream_link:String, artwork_url:String, tag:String, completion: @escaping (_ success:Bool) -> ()) {
    
    SVProgressHUD.show()
    
    let obj = PFObject(className: "Post")
    obj["songId"] = song_id
    obj["songTitle"] = song_title
    obj["artist"] = artist
    obj["user"] = user
    obj["preview_link"] = preview_link
    obj["stream_link"] = stream_link
    obj["artwork_url"] = artwork_url
    obj["tag"] = tag
    obj["likes"] = []    
    obj.saveInBackground { (done, error) in
        SVProgressHUD.dismiss()
        if error == nil {
            completion(true)
        }else{
            completion(false)
        }
    }
}
