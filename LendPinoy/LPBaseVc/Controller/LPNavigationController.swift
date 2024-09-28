//
//  LPNavigationController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import UIKit

class LPNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
}

extension LPNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if self.tabBarController != nil {
            LPTabBarManager.hideTabBar()
        }
        
    }
    
}

class LPTabBarManager {
    
    static func showTabBar() {
        if let navigationController = UIApplication.shared.delegate?.window??.rootViewController as? LPNavigationController {
            if let tabBarController = navigationController.viewControllers.first as? LPTabBarViewController {
                tabBarController.showTabBar()
            }
        }
    }
    
    static func hideTabBar() {
        if let navigationController = UIApplication.shared.delegate?.window??.rootViewController as? LPNavigationController {
            if let tabBarController = navigationController.viewControllers.first as? LPTabBarViewController {
                tabBarController.hideTabBar()
            }
        }
    }
}
