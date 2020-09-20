//
//  ProfileViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import ChameleonFramework
import SpringButton
import Parse
import EFCountingLabel


class ScrollView : UIScrollView {
    
    var profilePicture:UIImageView!
    var name:BoldLabel!
    var email:DetailLabel!
    
    var followers:EFCountingLabel!
    var followerLabel:CenterLabel!
    
    var spacer:UIView = UIView()
    
    
    init() {
        super.init(frame: .zero)
        
        profilePicture = UIImageView()
        profilePicture.layer.cornerRadius = 50
        profilePicture.clipsToBounds = true
        profilePicture.backgroundColor = UIColor(white: 0.97, alpha: 1)
        self.addSubview(profilePicture)
                        
        self.profilePicture.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        name = BoldLabel()
        name.text = "First Last"
        name.textAlignment = .center
        self.addSubview(name)
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(self.profilePicture.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        email = DetailLabel()
        email.text = "example@ucdavis.edu"
        email.textColor = UIColor(white: 0.7, alpha: 1.0)
        email.textAlignment = .center
        self.addSubview(email)
        
        email.snp.makeConstraints { (make) in
            make.top.equalTo(self.name.snp.bottom).offset(0)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        
        followers = EFCountingLabel()
        followers.text = "0"
        followers.textAlignment = .center
        followers.textColor = UIColor.black
        followers.font = UIFont(name: "AvenirNext-UltraLight", size: 60)
        self.addSubview(followers)
        
        followers.snp.makeConstraints { (make) in
            make.top.equalTo(self.email.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        
        followerLabel = CenterLabel()
        followerLabel.text = "followers"
        followerLabel.font = .detail
        followerLabel.textColor = UIColor(white: 0.7, alpha: 1)
        self.addSubview(followerLabel)
        
        followerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.followers.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        self.addSubview(spacer)
        spacer.snp.makeConstraints { (make) in
            make.top.equalTo(self.followerLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.alwaysBounceVertical = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ProfileViewController : UIViewController {

    var scrollView: ScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.hideLine()
        
        scrollView = ScrollView()
        self.view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // Profile gradient text
        let inst = CenterLabel()
        inst.text = "Profile"
        inst.sizeToFit()
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let grad = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: CGRect(x: 0, y: 0, width: inst.intrinsicContentSize.width+25, height: inst.intrinsicContentSize.height), andColors: [pink, yellow])
        inst.textColor = grad
        self.navigationItem.titleView = inst
        
        // Logout
        let logout = SpringButton(style: .Minimal)
        logout.setImage(UIImage(named: "Exit")?.withRenderingMode(.alwaysTemplate), for: .normal)
        logout.imageView?.tintColor = .systemPink
        logout.color = .systemPink
        logout.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logout)
        
        logout.onTap {
            PFUser.logOutInBackground { (error) in
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        SpotifyAPI.me { (username, email, image, followers) in
            self.scrollView.profilePicture.kf.setImage(with: URL(string: image))
            self.scrollView.name.text = username
            self.scrollView.email.text = email
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SpotifyAPI.me { (username, email, image, followers) in
            self.scrollView.profilePicture.kf.setImage(with: URL(string: image))
            self.scrollView.name.text = username
            self.scrollView.email.text = email
            self.scrollView.followers.countFrom(0, to: CGFloat(followers), withDuration: 2.0)
        }
    }
    
}
