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


class ProfileViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.hideLine()
        
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
    }
    
}
