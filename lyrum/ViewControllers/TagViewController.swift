//
//  TagViewController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import ChameleonFramework
import Magnetic
import SpringButton
import Parse


class TagViewController : UIViewController, MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        chosenTag = node.text!
        print(chosenTag)
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        
    }
        
    var magnetic: Magnetic?
    var allTags:[String] = ["chill", "hype", "fire", "sad", "relaxing", "beast mode", "happy", "good vibes", "hip hop", "classical", "deep house", "summer", "morning", "work out", "rock", "gaming", "dance", "at home", "party", "sleep", "anime", "jazz", "soul", "romance", "baby making music"]
    var chosenTag:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .systemPink
        let yourBackImage = UIImage(named: "BackArrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let inst = CenterLabel()
        inst.text = "Tag your Song"
        inst.sizeToFit()
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let grad = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: CGRect(x: 0, y: 0, width: inst.intrinsicContentSize.width+25, height: inst.intrinsicContentSize.height), andColors: [pink, yellow])
        inst.textColor = grad
        self.navigationItem.titleView = inst
        
        let magneticView = MagneticView(frame: self.view.bounds)
        magnetic?.allowsMultipleSelection = false
        magnetic = magneticView.magnetic
        magnetic?.magneticDelegate = self
        self.view.addSubview(magneticView)
        
        let submit = SpringButton(style: .Minimal)
        submit.setImage(UIImage(named: "Check")?.withRenderingMode(.alwaysTemplate), for: .normal)
        submit.imageView?.tintColor = .systemPink
        submit.color = .systemPink
        submit.sizeToFit()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submit)
        
        submit.onTap {
            submit.released()
            
            create_post(song_title: "2 am", song_id: "", artist: "Che Ecru", user: PFUser.current()!, preview_link: "", stream_link: "", artwork_url: "", tag: self.chosenTag) { (done) in
                if (!done) {
                    self.showPopup()
                }else{
                    self.dismiss(animated: true, completion: nil)
                }
            }

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
        
        
        for i in allTags {
            let node = Node(text: i, image: nil, color: UIColor.init(red: 255/255, green: 0/255, blue: 100/255, alpha: 1.0), radius: 50)
//            node.selectedColor = UIColor.init(red: 245/255, green: 30/255, blue: 130/255, alpha: 1.0)
            node.selectedFontColor = UIColor.init(red: 255/255, green: 0/255, blue: 100/255, alpha: 1.0)
            node.selectedColor = .white
            self.magnetic?.addChild(node)
        }
    }
}
