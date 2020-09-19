//
//  SceneDelegate.swift
//  lyrum
//
//  Created by Josh Arnold on 9/18/20.
//

import UIKit
import Parse


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
//        window?.rootViewController = LoginViewController()
        
        // NavigationController(rootViewController: ContentViewController())
        
        window?.rootViewController = TabViewController()
        
        if (PFUser.current() != nil) {
//            window?.rootViewController = RegularUserTabController()
        }
        
        window?.makeKeyAndVisible()
        
        // Try to get refresh token as many times as possible lol
        SpotifyAPI.is_user_logged_in_through_spotify { (success, error) in
            
            guard success == true else {
                
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.window?.rootViewController?.present(vc, animated: true, completion: nil)
                
                return
            }
            
            // TRIGGER SEGWAY INTO LOGIN FLOW..?
            print("Successfully logged in user!")
        }
        
        // Print for debugging
        SpotifyAPI.access_token { (done) in
            if (done) {
                print(SpotifyConstants.ACCESS_TOKEN)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        // Try to get refresh token as many times as possible lol
        SpotifyAPI.is_user_logged_in_through_spotify { (success, error) in
            
            guard success == true else {
                return
            }
            
            // TRIGGER SEGWAY INTO LOGIN FLOW..?
            print("Successfully logged in user!")
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

