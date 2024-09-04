//
//  LPNavigationController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
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
        updateTabBarVisibility()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let viewController = super.popViewController(animated: animated)
        updateTabBarVisibility()
        return viewController
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        updateTabBarVisibility()
    }
    
    private func updateTabBarVisibility() {
        if let tabBarController = self.tabBarController {
            if viewControllers.count > 1 {
                LPTabBarManager.hideTabBar()
            } else {
                LPTabBarManager.showTabBar()
            }
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
