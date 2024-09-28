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
    
}

extension LPLoginInfo {
    
    static func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    static func getLogiInfo() -> [String: String] {
        let sessionId = UserDefaults.standard.string(forKey: LP_SESSIONID) ?? ""
        var logInfo: [String: String] = [
            "appVersion": getAppVersion(),
            "systemVersion": UIDevice.current.systemVersion,
            "colorTheme": "pink",
            "contentType": "testjson",
            "sessionId": sessionId,
            "carModel1": "m3",
            "carModel2": "s6",
            "lighterBrand": "fire"
        ]
        
        let additionalInfo: [String: String] = [
            "iCloudEnabled": "1",
            "deviceIdentifier": KeychainHelper.retrieveidfv() ?? "",
            "deviceDescription": Device.current.description,
            "systemName": "iOS",
            "manufacturer": "apple",
            "isTwins": "0",
            "gender": "boy",
            "peaceStatus": "1",
            "mark": "allpo"
        ]
        
        logInfo.merge(additionalInfo) { (_, new) in new }
        
        return logInfo
    }
}
