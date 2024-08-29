//
//  AppDelegate.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LPLaunchViewController()
        keyJaiPan()
        window?.makeKeyAndVisible()
        jieshoutongzhi()
        return true
    }

}

extension AppDelegate {
    
    func keyJaiPan() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
    }
    
    func jieshoutongzhi() {
        NotificationCenter.default.addObserver(self, selector: #selector(getRootVc), name: NSNotification.Name(ROOT_VC_NOTI), object: nil)
    }
    
    @objc func getRootVc() {
        let tabBarVc = LPTabBarViewController()
        window?.rootViewController = tabBarVc
    }
    
}
