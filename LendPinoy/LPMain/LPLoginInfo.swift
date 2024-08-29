//
//  LPLoginInfo.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/29.
//

import UIKit
import DeviceKit

class LPLoginInfo: NSObject {
    
    static func saveDengLuInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(sessionID, forKey: LP_SESSIONID)
        UserDefaults.standard.setValue(phone, forKey: LP_LOGIN)
        UserDefaults.standard.synchronize()
    }
    
    static func removeDengLuInfo() {
        UserDefaults.standard.setValue("", forKey: LP_SESSIONID)
        UserDefaults.standard.setValue("", forKey: MAIDIAN1)
        UserDefaults.standard.setValue("", forKey: LP_LOGIN)
        UserDefaults.standard.synchronize()
    }
    
    static func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "1.0.0"
    }
    
    static func getLoginParas() -> [String: String]{
        
        var moist: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: LP_SESSIONID) as? String {
            moist = sessionId
        }
        
        let dict1 = ["sense": getAppVersion(),
                     "justice": UIDevice.current.systemVersion,
                     "yellow": "lucky",
                     "white": "black",
                     "remem": moist,
                     "bmw": "m5",
                     "zipo": "fire"]
        
        let dict2 = ["icloud": "1",
                     "undulating": KeychainHelper.retrieveIDFVFromKeychain() ?? "",
                     "peel": Device.current.description,
                     "yuzu": KeychainHelper.retrieveIDFVFromKeychain() ?? "",
                     "normally": "iOS",
                     "boyfine": "apple",
                     "twins": "0"]
        
        let allDict = dict2.reduce(into: dict1) { (result, item) in
            result[item.key] = item.value
        }
        return allDict
    }
    
}

