//
//  ContentViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import ChameleonFramework


class HotNewControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(items: ["Hot", "New"])
        self.backgroundColor = .white
        
        self.selectedSegmentIndex = 0
        self.backgroundColor = .white
        
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        self.selectedSegmentTintColor = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: self.frame.insetBy(dx: 20, dy: 0), andColors: [pink, yellow])
        
        let font: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : UIFont.small, NSAttributedString.Key.foregroundColor: UIColor(white: 0.90, alpha: 1)]
        self.setTitleTextAttributes(font, for: .normal)
        
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(self.numberOfSegments-1)  {
                    let backgroundSegmentView = self.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
//                    backgroundSegmentView.backgroundColor = UIColor(white: 1.0, alpha: 1)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class NavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
}


class ContentViewController: UIViewController {
    
    var hotNew:HotNewControl!
    
    var hotTableView:ContentTableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.view.backgroundColor = .white
        
        self.hotNew.onChange { (idx) in
//            if idx == 0 {
//                showPopup(title: "Hot", message: "Showing whats spicy atm.")
//            }else{
//                showPopup(title: "New", message: "Showing most recent posts.")
//            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        query_for_posts { (done, obj) in
            self.hotTableView.objects = obj
            self.hotTableView.reloadData()
        }
    }
}


extension ContentViewController {
    func setupUI() {
        hotNew = HotNewControl()
        self.navigationItem.titleView = hotNew
        
        hotTableView = ContentTableView(identifier: "hot")
        view.addSubview(hotTableView)
        
        hotTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
