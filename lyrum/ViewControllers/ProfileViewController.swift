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
            
    var favArtistsLabel:BoldLabel!
    var im1:UIImageView!
    var im2:UIImageView!
    var im3:UIImageView!
    var im4:UIImageView!
    var im5:UIImageView!
    var im6:UIImageView!
    
    var favSongsLabel:BoldLabel!
    
    var art1:UIImageView!
    var songLabel1:DetailLabel!
    
    var art2:UIImageView!
    var songLabel2:DetailLabel!
    
    var art3:UIImageView!
    var songLabel3:DetailLabel!
    
    var spacer:UIView = UIView()
    
    
    init() {
        super.init(frame: .zero)
        
        self.showsVerticalScrollIndicator = false
        
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
            make.top.equalTo(self.email.snp.bottom).offset(50)
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
        
        
        favArtistsLabel = BoldLabel()
        favArtistsLabel.text = "Favourite Artists"
        self.addSubview(favArtistsLabel)
        
        favArtistsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.followerLabel.snp.bottom).offset(50)
            make.width.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
            
        im1 = UIImageView()
        im1.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(im1)
        im1.snp.makeConstraints { (make) in
            make.top.equalTo(self.favArtistsLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(im1.snp.width)
        }
        
        im2 = UIImageView()
        im2.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.addSubview(im2)
        im2.snp.makeConstraints { (make) in
            make.top.equalTo(self.favArtistsLabel.snp.bottom).offset(5)
            make.left.equalTo(self.im1.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(im2.snp.width)
        }
        
        im3 = UIImageView()
        im3.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(im3)
        im3.snp.makeConstraints { (make) in
            make.top.equalTo(self.favArtistsLabel.snp.bottom).offset(5)
            make.left.equalTo(self.im2.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(im3.snp.width)
        }
        
        im4 = UIImageView()
        im4.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.addSubview(im4)
        im4.snp.makeConstraints { (make) in
            make.top.equalTo(self.im1.snp.bottom)
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(im4.snp.width)
        }
        
        im5 = UIImageView()
        im5.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(im5)
        im5.snp.makeConstraints { (make) in
            make.top.equalTo(self.im2.snp.bottom)
            make.left.equalTo(self.im4.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(im5.snp.width)
        }
        
        im6 = UIImageView()
        im6.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        self.addSubview(im6)
        im6.snp.makeConstraints { (make) in
            make.top.equalTo(self.im3.snp.bottom)
            make.left.equalTo(self.im5.snp.right)
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(im6.snp.width)
        }
        
        
        favSongsLabel = BoldLabel()
        favSongsLabel.text = "Favourite Songs"
        self.addSubview(favSongsLabel)
        
        favSongsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.im5.snp.bottom).offset(50)
            make.width.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        }
        
        
        
        art1 = UIImageView()
        art1.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(art1)
        
        art2 = UIImageView()
        art2.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(art2)
        
        art3 = UIImageView()
        art3.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(art3)
        
        
        songLabel1 = DetailLabel()
        self.addSubview(songLabel1)
        
        songLabel2 = DetailLabel()
        self.addSubview(songLabel2)
        
        songLabel3 = DetailLabel()
        self.addSubview(songLabel3)
        
        
        art1.snp.makeConstraints { (make) in
            make.top.equalTo(self.favSongsLabel.snp.bottom).offset(5)
            make.width.height.equalTo(60)
        }
                    
        art2.snp.makeConstraints { (make) in
            make.top.equalTo(self.art1.snp.bottom).offset(0)
            make.width.height.equalTo(60)
        }
        
        art3.snp.makeConstraints { (make) in
            make.top.equalTo(self.art2.snp.bottom).offset(0)
            make.width.height.equalTo(60)
        }
        
        
        songLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(self.favSongsLabel.snp.bottom).offset(5)
            make.left.equalTo(art1.snp.right).offset(5)
            make.right.equalToSuperview()
            make.height.equalTo(self.art1.snp.height)
        }
        
        songLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(self.art2.snp.bottom).offset(5)
            make.left.equalTo(art2.snp.right).offset(5)
            make.right.equalToSuperview()
            make.height.equalTo(self.art2.snp.height)
        }
        
        songLabel3.snp.makeConstraints { (make) in
            make.top.equalTo(self.art3.snp.bottom).offset(5)
            make.left.equalTo(art3.snp.right).offset(5)
            make.right.equalToSuperview()
            make.height.equalTo(self.art3.snp.height)
        }
        
        
        self.addSubview(spacer)
        spacer.snp.makeConstraints { (make) in
            make.top.equalTo(self.art3.snp.bottom)
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
            
            self.scrollView.songLabel1.text = "1. 2 am By Che Ecru"
            self.scrollView.songLabel2.text = "2. Sonic Boom by Roy Woods"
            self.scrollView.songLabel3.text = "3. She is the Moon By vbnd"
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
