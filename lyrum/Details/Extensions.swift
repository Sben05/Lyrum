//
//  Extensions.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit
import PopupDialog


extension UIViewController {
    func showPopup(title:String="Uh oh", message:String="Something went wrong!") {
        let popup = PopupDialog(title: title, message: message)
        let buttonOne = CancelButton(title: "OK") {}
        popup.addButton(buttonOne)
        self.present(popup, animated: true, completion: nil)
    }
}
