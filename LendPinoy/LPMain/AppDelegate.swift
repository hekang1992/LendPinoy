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
        let notification = Notification(name: Notification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
        getRootVc(notification)
        window?.makeKeyAndVisible()
        jieshoutongzhi()
        keyJaiPan()
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
    
    @objc func getRootVc(_ noti: Notification) {
        guard let guest = noti.userInfo?["guest"] as? String else { return }
        let rootViewController: UIViewController
        if guest == "1" {
            rootViewController = LPTabBarViewController()
        } else {
            rootViewController = IS_LOGIN ? LPTabBarViewController() : LPLaunchViewController()
        }
        window?.rootViewController = LPNavigationController(rootViewController: rootViewController)
    }
    
}
