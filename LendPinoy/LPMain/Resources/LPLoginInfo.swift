//
//  LPLoginInfo.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/29.
//

import UIKit
import DeviceKit

class LPLoginInfo: NSObject {
    
    static func removeDengLuInfo() {
        UserDefaults.standard.setValue("", forKey: LP_SESSIONID)
        UserDefaults.standard.setValue("", forKey: LP_LOGIN)
        UserDefaults.standard.setValue("", forKey: MAI_DIAN_ONE)
        UserDefaults.standard.setValue("", forKey: LOGIN_END_LP)
        UserDefaults.standard.setValue("", forKey: LOGIN_START_LP)
        UserDefaults.standard.synchronize()
    }
    
    static func saveDengLuInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(sessionID, forKey: LP_SESSIONID)
        UserDefaults.standard.setValue(phone, forKey: LP_LOGIN)
        UserDefaults.standard.setValue("", forKey: MAI_DIAN_ONE)
        UserDefaults.standard.synchronize()
    }
    
    static func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "1.0.0"
    }
    
    static func getLogiInfo() -> [String: String]{
        
        var moist: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: LP_SESSIONID) as? String {
            moist = sessionId
        }
        
        let dict1 = ["sense": getAppVersion(),
                     "scrap": UIDevice.current.systemVersion,
                     "yellow": "lucky",
                     "form": "data",
                     "backColor": "pink",
                     "Content": "testjson",
                     "moist": moist,
                     "bmw": "m3",
                     "audi": "s6",
                     "zipo": "fire"]
        
        let dict2 = ["icloud": "1",
                     "appeared": KeychainHelper.retrieveidfv() ?? "",
                     "peel": Device.current.description,
                     "yuzu": KeychainHelper.retrieveidfv() ?? "",
                     "normally": "iOS",
                     "item": "apple",
                     "twins": "0",
                     "boyGirl": "boy",
                     "peace": "1",
                     "allpo": "mark"]
        
        let loict = dict2.reduce(into: dict1) { (result, item) in
            result[item.key] = item.value
        }
        return loict
    }
    
}

