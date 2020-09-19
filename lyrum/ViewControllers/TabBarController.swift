//
//  TabBarController.swift
//  lyrum
//
//  Created by Josh Arnold on 9/19/20.
//

import UIKit


class ShouldPresentViewController: UIViewController {}


class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.removeTabbarItemsText()
        
        self.tabBar.setValue(true, forKey: "_hidesShadow")
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.isOpaque = true
        self.tabBar.tintColor = .systemPink
        self.tabBar.barTintColor = .white
        
        self.delegate = self
        
        let firstViewController = NavigationController(rootViewController: ContentViewController())
        firstViewController.tabBarItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "SingleNote"), tag: 0)
        
        let secondViewController = ShouldPresentViewController()
        secondViewController.tabBarItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "Plus"), tag: 1)
        
        let thirdViewController = NavigationController(rootViewController: ContentViewController())
        thirdViewController.tabBarItem = UITabBarItem.init(title: nil, image: UIImage.init(named: "User"), tag: 2)
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        viewControllers = tabBarList
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is ShouldPresentViewController {
            let vc = NavigationController(rootViewController: SearchViewController())            
            vc.view.backgroundColor = .white
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return false
        }
        
        return true
    }
}


extension UIViewController {
    func removeTabbarItemsText() {

        var offset: CGFloat = 6.0

        if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
            offset = 0.0
        }

        if let items = self.tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
                item.imageInsets = UIEdgeInsets(top: offset, left: 0, bottom: -offset, right: 0)
            }
        }
    }
}
