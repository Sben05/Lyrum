//
//  SpringButton.swift
//  Pods-SpringButton_Example
//
//  Created by Josh Arnold on 9/10/19.
//

import UIKit
import SnapKit
import pop

public enum SpringButtonType {
    case Minimal
    case Default
    case Outline
}

open class SpringButton: UIButton {
    
    /** The primary color of the button. */
    public var color:UIColor = UIColor(red: 0.35, green: 0.2, blue: 0.95, alpha: 1) {
        didSet {
            self.setStyle()
        }
    }
    
    /** Set the text of the button */
    public var text:String? = "" {
        didSet {
            self.setTitle(self.text, for: .normal)            
        }
    }
    
    /** Set the font of the button */
    public var buttonFont:UIFont = UIFont(name: "AvenirNext-Regular", size: 16)! {
        didSet {
            self.titleLabel!.font = self.buttonFont
        }
    }    
    
    /** The text color of the button. */
    public var textColor:UIColor? = .white {
        didSet {
            self.setTitleColor(self.textColor, for: .normal)
        }
    }
    
    /** The text color of the button when pressed. */
    public var highlightTextColor:UIColor? = .white {
        didSet {
            self.setTitleColor(highlightTextColor, for: .highlighted)
        }
    }
    
    /** The corner radius of the button. */
    public var cornerRadius:CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    /** The scale of the button when pressed */
    public var buttonScale:CGFloat! = 0.85
    
    /** The speed of the button wobble. */
    public var speed:CGFloat! = 20
    
    /** The bounciness of the sprint. */
    public var bounce:CGFloat! = 15
    
    /** The appearance of the button. */
    public var style:SpringButtonType = .Default {
        didSet {
            self.setStyle()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(style:SpringButtonType = .Default) {
        super.init(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        if let center = UIApplication.shared.keyWindow?.rootViewController?.view.center {
            self.center = center
        }
        self.style = style
        self.setStyle()
        self.configure()
    }
    
    public init(frame: CGRect, style:SpringButtonType = .Default) {
        super.init(frame: frame)
        self.style = style
        self.setStyle()
        self.configure()
    }
    
    /** Set the initial variables */
    private func configure() {
        self.cornerRadius = 9
        self.textColor = .white
        self.highlightTextColor = UIColor.init(white: 0.9, alpha: 1)
        self.color = UIColor(red: 87/255, green: 144/255, blue: 201/255, alpha: 1)
        self.buttonFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        // Add targets
        self.addTarget(self, action: #selector(SpringButton.pressed), for: .touchDown)
        self.addTarget(self, action: #selector(SpringButton.released), for: .touchUpInside)
        self.addTarget(self, action: #selector(SpringButton.released), for: .touchUpOutside)
        self.addTarget(self, action: #selector(SpringButton.released), for: .touchCancel)
    }
    
    private func setStyle() {
        if style == .Default {
            self.backgroundColor = color
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
        }else if style == .Outline {
            self.backgroundColor = UIColor.clear
            self.textColor = self.color
            self.layer.borderColor = self.color.cgColor
            self.layer.borderWidth = 1
        }else if style == .Minimal {
            self.backgroundColor = UIColor.clear
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
            self.textColor = self.color
        }
    }
    
    /** Called when the button is pressed */
    @objc public func pressed() {
        let anim = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        anim?.fromValue = CGSize(width: 1, height: 1)
        anim?.toValue = CGSize(width: 1*buttonScale, height: 1*buttonScale)
        anim?.springBounciness = self.bounce
        anim?.springSpeed = self.speed
        self.layer.pop_add(anim, forKey: "SpringButton")
    }
    
    /** Called when the button is released */
    @objc public func released() {
        let anim = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        anim?.toValue = CGSize(width: 1, height: 1)
        anim?.fromValue = CGSize(width: 1*buttonScale, height: 1*buttonScale)
        anim?.springBounciness = self.bounce
        anim?.springSpeed = self.speed
        self.layer.pop_add(anim, forKey: "SpringButton")
    }
    
}
