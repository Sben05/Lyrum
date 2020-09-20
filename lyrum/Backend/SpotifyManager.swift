//
//  SpotifyManager.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import WebKit
import SVProgressHUD
import Alamofire
import EasyStash


class SpotifyConstants {
    static let CLIENT_ID:String = "bcac94c5e73345bd9e108357d7680a42"
    static let SCOPE:String = "user-read-email"
    static let REDIRECT_URI:String = "spotify-ios-quick-start://spotify-login-callback"
    
    static var CODE:String = ""
    static var REFRESH_TOKEN:String = ""
    static var ACCESS_TOKEN:String = ""
    
    static var USER_ID:String = ""
    static var DISPLAY_NAME:String = ""
}


class SpotifyAPI {
    
    /**
     Make a request to our API end point so client secret is hidden, updates the constants with a refresh tookken
     */
    static func obtain_a_refresh_token(completion: @escaping (_ success:Bool, _ error:Error?) -> ()) {
            
        let url = "http://ec2-18-219-166-211.us-east-2.compute.amazonaws.com:8000/refreshtoken?code=" + SpotifyConstants.CODE
        
        let req = AF.request(url, method: .get)
        
        req.responseJSON { (data) in
            if data.error == nil {
                if let res = data.value as? [String:Any] {
                    if let access = res["access_token"] as? String {
                        SpotifyConstants.ACCESS_TOKEN = access
                    }
                    if let refresh = res["refresh_token"] as? String {
                        SpotifyConstants.REFRESH_TOKEN = refresh
                        print("\n\n")
                        print(SpotifyConstants.REFRESH_TOKEN)
                        print("\n\n")
                    }
                    var options = Options()
                    options.folder = "Local"
                    let storage = try! Storage(options: options)
                    try? storage.save(object: SpotifyConstants.REFRESH_TOKEN, forKey: "refresh_token")
                    try? storage.save(object: SpotifyConstants.ACCESS_TOKEN, forKey: "access_token")
                    try? storage.save(object: Date(), forKey: "access_token_creation_date")
                    completion(true, nil)
                }
            }else{
                completion(false, data.error)
            }
        }
    }
    
    /**
     Returns the user's profile!
     */
    static func user_profile(completion: @escaping (_ success:Bool, _ error:Error?) -> ()) {
        SpotifyAPI.access_token { (done) in
            if done == false {
                completion(false, nil)
                return
            }
                        
            let url = "http://ec2-18-219-166-211.us-east-2.compute.amazonaws.com:8000/me?id=" + SpotifyConstants.ACCESS_TOKEN
            let req = AF.request(url, method: .get)
            
            req.responseJSON { (data) in
                if data.error == nil {
                    if let res = data.value as? [String:Any] {
                                                                    
                        if let x = res["id"] as? String {
                            SpotifyConstants.USER_ID = x
                        }
                        
                        if let x = res["display_name"] as? String {
                            SpotifyConstants.DISPLAY_NAME = x
                        }
                        
                        completion(true, nil)
                        return
                    }
                }
                completion(false, data.error)
            }
        }
    }
    
    /**
     Gives us a latest access token!
     */
    static func access_token(completion: @escaping (_ success:Bool) -> ()) {
        let url = "http://ec2-18-219-166-211.us-east-2.compute.amazonaws.com:8000/accessusingrefresh?code=" + SpotifyConstants.REFRESH_TOKEN
        let req = AF.request(url, method: .get)
        req.responseJSON { (data) in
            if data.error == nil {
                if let res = data.value as? [String:Any] {                            
                    if let access = res["access_token"] as? String {
                        SpotifyConstants.ACCESS_TOKEN = access
                        print("\n\nAccess, token:")
                        print(SpotifyConstants.ACCESS_TOKEN)
                        print("\n\n")
                        completion(true)
                        return
                    }
                }
            }
            completion(false)
            return
        }
    }
    
    /**
    Loads refresh token from device from where it was saved
     */
    static func is_user_logged_in_through_spotify(completion: @escaping (_ success:Bool, _ error:Error?) -> ()) {
        var options = Options()
        options.folder = "Local"
        let storage = try! Storage(options: options)
        if let refresh_token: String = try? storage.load(forKey: "refresh_token", as: String.self) {
            SpotifyConstants.REFRESH_TOKEN = refresh_token
            completion(true, nil)
        }else{
            completion(false, nil)
        }
    }
}


protocol SpotifyLoginDelegate {
    func loginError()
    func loginSuccess()
}


class SpotifyViewController : UIViewController, WKNavigationDelegate {
    
    var webView = WKWebView()
    
    var delegate:SpotifyLoginDelegate?
    
    override func viewDidLoad() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        self.navigationItem.leftBarButtonItem = cancelButton
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        self.navigationItem.rightBarButtonItem = refreshButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "spotify.com"
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func refreshAction() {
        self.webView.reload()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        RequestForCallbackURL(request: navigationAction.request)
        decisionHandler(.allow)
    }

    func RequestForCallbackURL(request: URLRequest) {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(SpotifyConstants.REDIRECT_URI) {
            SpotifyConstants.CODE = requestURLString.components(separatedBy: "code=")[1]
            handleAuth()
        }
    }
    
    func handleAuth() {
        self.dismiss(animated: true, completion: nil)
        
        SVProgressHUD.show()
            
        SpotifyAPI.obtain_a_refresh_token { (success, error) in
            
            guard success == true else {
                SVProgressHUD.dismiss()
                self.delegate?.loginError()                
                return
            }
            
            SpotifyAPI.user_profile { (success, error) in
                                
                guard success == true else {
                    SVProgressHUD.dismiss()
                    self.delegate?.loginError()
                    return
                }
                                                                
                self.delegate?.loginSuccess()
            }
        }
    }
}


extension LoginViewController {
        
    func request_access_token() {
                
        // Init vc
        let spotifyVC = SpotifyViewController()
        spotifyVC.delegate = self
        
        // Load request //token&client_id
        let authURLFull = "https://accounts.spotify.com/authorize?response_type=code&client_id=" + SpotifyConstants.CLIENT_ID + "&scope=" + SpotifyConstants.SCOPE + "&redirect_uri=" + SpotifyConstants.REDIRECT_URI + "&show_dialog=true"
        let urlRequest = URLRequest.init(url: URL.init(string: authURLFull)!)
        spotifyVC.webView.load(urlRequest)
        
        // Create Navigation Controller
        let navController = UINavigationController(rootViewController: spotifyVC)
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.black
        navController.navigationBar.barTintColor = UIColor.white
        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        navController.modalTransitionStyle = .coverVertical

        // Present
        self.present(navController, animated: true, completion: nil)
    }
}
