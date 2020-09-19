//
//  Database.swift
//  lyrum
//
//  Created by Josh Arnold on 9/18/20.
//

import Parse


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
