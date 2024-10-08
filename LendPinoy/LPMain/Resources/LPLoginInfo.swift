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
        let keys = [LP_SESSIONID, LP_LOGIN, MAI_DIAN_ONE, LOGIN_END_LP, LOGIN_START_LP]
        keys.forEach { UserDefaults.standard.setValue("", forKey: $0) }
        UserDefaults.standard.synchronize()
    }
    
    static func saveDengLuInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(sessionID, forKey: LP_SESSIONID)
        UserDefaults.standard.setValue(phone, forKey: LP_LOGIN)
        UserDefaults.standard.setValue("", forKey: MAI_DIAN_ONE)
        UserDefaults.standard.synchronize()
    }
    
}

extension LPLoginInfo {
    
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    static func getLogiInfo() -> [String: String] {
        let moist = UserDefaults.standard.string(forKey: LP_SESSIONID) ?? ""
        
        var logInfo: [String: String] = ["sense": getAppVersion(),
                                         "form": "data_form",
                                         "backColor": "pink",
                                         "scrap": UIDevice.current.systemVersion,
                                         "Content": "jsoner",
                                         "moist": moist,
                                         "bmw": "m7",
                                         "audi": "as8",
                                         "zipo": "firelight",
                                         "delight": NetworkInfo.isVPNCd()]
        
        let additionalInfo: [String: String] = ["icloud": "1",
                                                "appeared": KeychainHelper.retrieveidfv() ?? "",
                                                "normally": "iOS",
                                                "peel": Device.current.description,
                                                "peace": "1",
                                                "yuzu": KeychainHelper.retrieveidfv() ?? "",
                                                "item": "apple",
                                                "allpo": "mark"]
        
        logInfo.merge(additionalInfo) { (_, new) in new }
        
        return logInfo
    }
}
