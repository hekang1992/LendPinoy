//
//  LPTabBarViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
//

import UIKit

class LPTabBarViewController: UITabBarController {
    
    var customTabBar: LPTabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureViewControllers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureTabBarVisibility()
    }
    
    private func setupTabBar() {
        let customTabBar = LPTabBar()
        self.customTabBar = customTabBar
        view.addSubview(customTabBar)
        customTabBar.block = { [weak self] tabBar, from, to in
            if IS_LOGIN {
                if from != to {
                    self?.selectedIndex = to
                }
            }else {
                let llauncVc = LPLaunchViewController()
                self?.navigationController?.pushViewController(llauncVc, animated: true)
            }
        }
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-StatusManager.safeAreaBottomHeight - 2)
            make.height.equalTo(60)
        }
    }
    
    private func configureViewControllers() {
        let homeVC = LPHomeViewController()
        let orderVC = LPOrdersViewController()
        let userVC = LPCenterViewController()
        
        setupChildViewController(homeVC, title: "Home", imageName: "home_home", selectedImageName: "home_home")
        setupChildViewController(orderVC, title: "Order", imageName: "order_order", selectedImageName: "order_order")
        setupChildViewController(userVC, title: "Profile", imageName: "user_user", selectedImageName: "user_user")
    }
    
    private func setupChildViewController(_ viewController: LPBaseViewController, title: String, imageName: String, selectedImageName: String) {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        if let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal) {
            viewController.tabBarItem.selectedImage = selectedImage
        }
        let navController = LPNavigationController(rootViewController: viewController)
        addChild(navController)
        self.customTabBar?.addTabBarButtonNorImageUrl(imageName, selImageUrl: selectedImageName, title: title)
    }
    
    private func configureTabBarVisibility() {
        tabBar.isHidden = true
        for subview in tabBar.subviews {
            let className = NSStringFromClass(type(of: subview))
            if className.contains("BarBackground") {
                subview.isHidden = true
            }
            if let control = subview as? UIControl {
                control.removeFromSuperview()
            }
        }
    }
    
    func showTabBar() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.customTabBar?.frame.origin.y = self.view.bounds.size.height - StatusManager.safeAreaBottomHeight - 62
            }
        }
    }
    
    func hideTabBar() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.customTabBar?.frame.origin.y = self.view.bounds.size.height
            }
        }
    }
    
}
