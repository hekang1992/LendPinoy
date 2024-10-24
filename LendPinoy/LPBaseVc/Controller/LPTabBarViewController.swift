//
//  LPTabBarViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import UIKit

class LPTabBarViewController: UITabBarController {
    
    private lazy var customTabBar: LPTabBar = {
        let customTabBar = LPTabBar()
        return customTabBar
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
                let llauncVc = LPLaunchViewController()
                self?.navigationController?.pushViewController(llauncVc, animated: true)
            }
        }
        customTabBar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-(StatusManager.safeAreaBottomHeight + 2))
            make.height.equalTo(50)
        }
    }
    
    private func configureViewControllers() {
        let homeVC = LPHomeViewController()
        let orderVC = LPOrdersViewController()
        let userVC = LPCenterViewController()
        
        setupChildViewController(homeVC, title: "", imageName: "home_no", selectedImageName: "home_sel")
        setupChildViewController(orderVC, title: "", imageName: "order_nor", selectedImageName: "order_sel")
        setupChildViewController(userVC, title: "", imageName: "user_nor", selectedImageName: "user_sel")
    }
    
    private func setupChildViewController(_ viewController: LPBaseViewController, title: String, imageName: String, selectedImageName: String) {
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        if let selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal) {
            viewController.tabBarItem.selectedImage = selectedImage
        }
        let navController = LPNavigationController(rootViewController: viewController)
        addChild(navController)
        self.customTabBar.addTabBarButtonNorImageUrl(imageName, selImageUrl: selectedImageName, title: title)
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
            UIView.animate(withDuration: 0.2) {
                self.customTabBar.alpha = 1
            }
        }
    }
    
    func hideTabBar() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.customTabBar.alpha = 0
            }
        }
    }
    
}
