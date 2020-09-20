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


extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}


extension UITableView {

    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
