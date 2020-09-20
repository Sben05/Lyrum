//
//  CommentViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import Parse
import SnapKit
import ChameleonFramework


class CommentViewController: UIViewController {
    
    var post:PFObject!
    
    init(post:PFObject) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()

    }
}


extension CommentViewController {
    
    func setup() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .systemPink
        let yourBackImage = UIImage(named: "BackArrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let inst = CenterLabel()
        inst.text = "Comments"
        inst.sizeToFit()
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let grad = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: CGRect(x: 0, y: 0, width: inst.intrinsicContentSize.width+25, height: inst.intrinsicContentSize.height), andColors: [pink, yellow])
        inst.textColor = grad
        self.navigationItem.titleView = inst
    }
}
