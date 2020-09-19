//
//  LoginViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/18/20.
//

import UIKit
import Gradients
import SnapKit
import SpringButton
import WebKit
import Alamofire
import SVProgressHUD

class LoginViewController: UIViewController, SpotifyLoginDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var titleLabel:TitleLabel!
    var descriptionLabel:CenterLabel!
    var icon:UIImageView!
    var login: SpringButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layout_ui()
        
        self.login.onTap {
            self.login.released()
            self.request_access_token()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.add_gradient()
    }
    
    func loginError() {
        self.showPopup()
        print("login error...?")
    }
    
    func loginSuccess() {
        does_user_exist(user_id: SpotifyConstants.USER_ID) { (exists) in
            
            if (exists) {
                login_user(user_id: SpotifyConstants.USER_ID) { (done) in
                    
                    SVProgressHUD.dismiss()
                    
                    if done {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.showPopup()
                    }
                }
            }else{
                sign_up_user(user_id: SpotifyConstants.USER_ID) { (success) in
                    
                    SVProgressHUD.dismiss()
                    
                    if (success) {
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.showPopup()
                    }
                }
            }
        }
    }
        
}

extension LoginViewController {
    
    func layout_ui() {
        
        self.titleLabel = TitleLabel()
        self.titleLabel.text = "lyrum"
        self.view.addSubview(self.titleLabel)
        
        self.descriptionLabel = CenterLabel()
        self.descriptionLabel.text = "The next generation music platform. Discover music. Share music."
        self.view.addSubview(self.descriptionLabel)
        
        self.icon = UIImageView(image: UIImage(named: "Notes"))
        self.icon.contentMode = .scaleAspectFit
        self.view.addSubview(self.icon)
        
        self.login = SpringButton(style: .Outline)
        self.login.text = " Login with Spotify"
        self.login.tintColor = .white
        self.login.color = .white
        self.login.buttonFont = UIFont.init(name: "AvenirNext-Medium", size: 20)!
        self.login.cornerRadius = 25
        self.login.setImage(UIImage(named: "Spotify"), for: .normal)
        self.view.addSubview(self.login)
        
        self.snap()
    }
    
    func snap() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.icon.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.login.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }
    }
}

extension LoginViewController {
    
    func add_gradient() {
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [pink.cgColor, yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
