//
//  LPTabBarViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
//

import UIKit

class LPTabBarViewController: UITabBarController {
    
    private lazy var customTabBar: PATabBar = {
        let tabBar = PATabBar()
        return tabBar
    }()
    
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
        view.addSubview(customTabBar)
        customTabBar.block = { [weak self] tabBar, from, to in
            if IS_LOGIN {
                if from != to {
                    self?.selectedIndex = to
                }
            }else {
                let loginVc = LPLoginViewController()
                loginVc.loginView.navView.backBtn.isHidden = true
                self?.navigationController?.pushViewController(loginVc, animated: true)
            }
        }
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.bottom.equalToSuperview().offset(-StatusHeightManager.safeAreaBottomHeight - 2.lpix())
            make.height.equalTo(60.lpix())
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
        customTabBar.addTabBarButtonNorImageUrl(imageName, selImageUrl: selectedImageName, title: title)
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
        UIView.animate(withDuration: 0.25) {
            self.customTabBar.frame.origin.y = self.view.bounds.size.height - StatusHeightManager.safeAreaBottomHeight - 62.lpix()
        }
    }
    
    func hideTabBar() {
        UIView.animate(withDuration: 0.25) {
            self.customTabBar.frame.origin.y = self.view.bounds.size.height
        }
    }
    
}
