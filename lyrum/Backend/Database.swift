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
    obj["numComments"] = 0
    
    obj.saveInBackground { (done, error) in
        SVProgressHUD.dismiss()
        if error == nil {
            completion(true)
        }else{
            completion(false)
        }
    }
}


func query_for_posts(completion: @escaping (_ success:Bool, _ objects: [PFObject]) -> ()) {
    let query = PFQuery(className: "Post")
    query.findObjectsInBackground { (obj, error) in
        if error == nil {
            completion(true, obj!)
        }else{
            completion(false, [])
        }
    }
}


func likePost(obj:PFObject) {
    obj.addUniqueObject(PFUser.current()!.objectId!, forKey: "likes")
    obj.saveInBackground()
}


func unlikePost(obj:PFObject) {
    obj.removeObjects(in: [PFUser.current()!.objectId!], forKey: "likes")
    obj.saveInBackground()
}


func commentPost(post:PFObject, text:String, user:PFUser, completion: @escaping (_ success: Bool) -> ()) {
    
    // Actually save obj
    post.incrementKey("numComments")
    post.saveInBackground()
}


func pfobj_to_song(obj:PFObject) -> Song {
    let song = Song()
    song.title = obj.object(forKey: "songTitle") as! String
    song.id = obj.object(forKey: "songId") as! String
    song.artist = obj.object(forKey: "artist") as! String
    song.artwork = obj.object(forKey: "artwork_url") as! String
    song.tag = obj.object(forKey: "tag") as! String
    song.preview = obj.object(forKey: "preview_link") as! String
    song.uri = obj.object(forKey: "stream_link") as! String
    return song
}
