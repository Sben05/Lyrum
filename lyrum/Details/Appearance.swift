//
//  Appearance.swift
//  lyrum
//
//  Created by Josh Arnold on 9/18/20.
//

import UIKit
import ChameleonFramework
import SpringButton

class TitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.title
        self.numberOfLines = 0
        self.textColor = .white
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class CenterLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.text
        self.numberOfLines = 0
        self.textColor = .white
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class BoldLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.bold
        self.numberOfLines = 0
        self.textColor = .black
        self.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DetailLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.detail
        self.numberOfLines = 0
        self.textColor = UIColor.init(white: 0.7, alpha: 1)
        self.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class SubDetailLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.subDetail
        self.numberOfLines = 0
        self.textColor = UIColor.init(white: 0.7, alpha: 1)
        self.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ToolbarButton : SpringButton {
    
    init(name:String) {
        super.init(style: .Minimal)
        self.setImage(UIImage(named: name)?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        self.imageView?.tintColor = UIColor(white: 0.8, alpha: 1)
//        self.imageView?.contentMode = .center

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class TagLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.small
        self.numberOfLines = 0
        self.textColor = UIColor.white
        self.textAlignment = .left
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.easyGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGradient() {
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let grad = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: CGRect(x: 0, y: 0, width: self.intrinsicContentSize.width+25, height: self.intrinsicContentSize.height), andColors: [pink, yellow])
        self.backgroundColor = grad
    }
    
    func easyGradient() {
        let pink = UIColor.init(red: 245/255, green: 0/255, blue: 155/255, alpha: 1.0)
        let yellow = UIColor.init(red: 255/255, green: 180/255, blue: 0, alpha: 1.0)
        let grad = UIColor.init(gradientStyle: UIGradientStyle.leftToRight, withFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: 50), andColors: [pink, yellow])
        self.backgroundColor = grad
    }
}



extension UIFont {
    static var title:UIFont {
        return UIFont(name: "AvenirNext-Bold", size: 40)!
    }

    static var bold:UIFont {
        return UIFont(name: "AvenirNext-Bold", size: 18)!
    }
    
    static var text:UIFont {
        return UIFont(name: "Avenir Next", size: 20)!
    }
    
    static var detail:UIFont {
        return UIFont(name: "Avenir Next", size: 15)!
    }
    
    static var subDetail:UIFont {
        return UIFont(name: "Avenir Next", size: 13)!
    }
    
    static var small:UIFont {
        return UIFont(name: "Avenir Next", size: 15)!
    }
}
