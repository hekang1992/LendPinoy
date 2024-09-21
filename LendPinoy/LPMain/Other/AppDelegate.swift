//
//  AppDelegate.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        keyJaiPan()
        jieshoutongzhi()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = LPNavigationController(rootViewController: LPLaunchViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
}

extension AppDelegate {
    
    func keyJaiPan() {
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true
    }
    
    func jieshoutongzhi() {
        NotificationCenter.default.addObserver(self, selector: #selector(getRootVc), name: NSNotification.Name(ROOT_VC_NOTI), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(byLoaction), name: NSNotification.Name(LOCATION_LP), object: nil)
    }
    
    @objc func getRootVc(_ noti: Notification) {
        guard let guest = noti.userInfo?["guest"] as? String else { return }
        let rootViewController: UIViewController
        if guest == "1" {//youke
            rootViewController = LPTabBarViewController()
        } else {
            if IS_LOGIN {
                rootViewController = LPTabBarViewController()
            }else {
                rootViewController = LPLaunchViewController()
            }
        }
        window?.rootViewController = LPNavigationController(rootViewController: rootViewController)
    }
    
    @objc func byLoaction() {
        let location = LPDingWeiManager()
        location.startUpdatingLocation { [weak self] locationModel in
            guard let self = self else { return }
            self.scDwInfo(locationModel)
        }
    }
    
    func scDwInfo(_ model: DingModel) {
        let manager = LPRequestManager()
        let wdDict = [
            "lightly": "us",
            "mizugashi": model.mizugashi ?? "",
            "dessert": model.dessert ?? "",
            "also": model.also ?? "",
            "conversation": model.conversation ?? "",
            "spice": model.spice,
            "shichimi": model.shichimi,
            "season": model.season ?? "",
            "turnip": Date(),
        ] as [String : Any]
        manager.uploadDataAPI(params: wdDict, pageUrl: "/lpinoy/nowhas/bean-scattering/place", method: .post) { result in
        }
        
        let sheDict = [
            "itself": DictToJsonString.dictStr(dict: LPSheBeiInfo.shebeiInfo()) ?? "",
            "worth": "center"]
        manager.uploadDataAPI(params: sheDict as [String : Any], pageUrl: "/lpinoy/nabeyaki-udon/remained/thumbing", method: .post) { result in
        }
        let typeStr = UserDefaults.standard.object(forKey: MAI_DIAN_ONE) as? String ?? ""
        if typeStr != "1" {
            let st: String = UserDefaults.standard.object(forKey: LOGIN_START_LP) as! String
            let en: String = UserDefaults.standard.object(forKey: LOGIN_END_LP) as! String
            let maiDict = [
                "mizuo": DeviceInfo.getIDFA(),
                "cupping": "1",
                "heike": "",
                "adds": KeychainHelper.retrieveidfv() ?? "",
                "shichimi": model.shichimi,
                "spice": model.spice,
                "village": st,
                "arm": en,
                "tucking": "mins"] as [String : Any]
            manager.uploadDataAPI(params: maiDict, pageUrl: "/lpinoy/chieko/thats/dripping", method: .post) { result in
                UserDefaults.standard.setValue("1", forKey: MAI_DIAN_ONE)
                UserDefaults.standard.synchronize()
            }
        }
    }
    
}
