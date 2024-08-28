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
        return true
    }

}

extension AppDelegate {
    
    func keyJaiPan() {
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
    }
    
}
