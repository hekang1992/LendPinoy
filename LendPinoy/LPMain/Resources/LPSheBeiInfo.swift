//
//  LPSheBeiInfo.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/29.
//

import UIKit
import SystemServices
import AdSupport
import DeviceKit
import SystemConfiguration.CaptiveNetwork

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

class DeviceInfo {
    
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    static func ScreenWidth() -> String {
        return String(format: "%.0f", UIScreen.main.bounds.size.width)
    }
    
    static func ScreenHeight() -> String {
        return String(format: "%.0f", UIScreen.main.bounds.size.height)
    }
    
    static func isSimulator() -> String {
        return Device.current.isSimulator ? "1" : "0"
    }
    
    static func getDeviceon() -> [String: Any] {
        return [
            "joining": "",
            "meantime": Device.current.name ?? "",
            "shortly": "",
            "wonderfully": ScreenHeight(),
            "shinshu": UIDevice.current.name,
            "matsutake": ScreenWidth(),
            "ginger": Device.current.description,
            "myoga": String(Device.current.diagonal),
            "cucumber": Device.current.systemVersion ?? ""
        ]
    }
}

class NetworkInfo {
    
    static func getSSIDInfo() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String],
              let interface = interfaces.first as CFString?,
              let info = CNCopyCurrentNetworkInfo(interface) as NSDictionary? else { return "" }
        return info["SSID"] as? String ?? ""
    }
    
    static func getBSSIDInfo() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String],
              let interface = interfaces.first as CFString?,
              let info = CNCopyCurrentNetworkInfo(interface) as NSDictionary? else { return "" }
        return info["BSSID"] as? String ?? ""
    }
    
    static func isUxy() -> String {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
              let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [[AnyHashable: Any]],
              let settings = proxies.first,
              let proxyType = settings[kCFProxyTypeKey] as? String else { return "0" }
        return proxyType == kCFProxyTypeNone as String ? "0" : "1"
    }
    
    static func isVPNCd() -> String {
        if let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any],
           let scopes = proxySettings["__SCOPED__"] as? [String: Any] {
            for key in scopes.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                    return "1"
                }
            }
        }
        return "0"
    }
    
    static func getWifiMac() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else { return "" }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary?,
                  let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else { continue }
            return bssid
        }
        return ""
    }
    
    static func getCurrentNetworkInfo() -> [String: Any] {
        return [
            "quench": getSSIDInfo(),
            "miyajima": getBSSIDInfo(),
            "aromas": getWifiMac(),
            "seared": getSSIDInfo()
        ]
    }
}

class LPSheBeiInfo {
    
    static func shebeiInfo() -> [String: Any] {
        var dict: [String: Any] = [
            "apple": "1",
            "thumbing": "2",
            "thicken": UIDevice.current.systemVersion,
            "kudzu": SystemInfo.getLastTime(),
            "grated": Bundle.main.bundleIdentifier ?? "",
            "warming": "iOS",
            "oil": "3"
        ]
        
        dict["crab"] = [
            "tilefish": SystemServices().batteryLevel,
            "fish": "yellowYu",
            "pigsy": "pid",
            "high": "180cm",
            "googs": "0",
            "lacquerware": SystemServices().charging ? 1 : 0
        ]
        
        dict["overdo"] = [
            "swift": "1",
            "drooling": KeychainHelper.retrieveidfv() ?? "",
            "practically": DeviceInfo.getIDFA(),
            "aromas": NetworkInfo.getWifiMac(),
            "faker": Device.current.systemName ?? "",
            "delight": NetworkInfo.isVPNCd(),
            "swiftcode": "true",
            "extending": SystemInfo.getCurrentTime(),
            "tsujitomi": NetworkInfo.isUxy(),
            "facebool": SystemInfo.getCurrentTime(),
            "agape": SecurityInfo.isJailBreak(),
            "is_simulator": DeviceInfo.isSimulator(),
            "json": "1",
            "melts": SystemServices().language ?? "",
            "octopus": SystemServices().carrierName ?? "",
            "balls": NetworkReachability.shared.netType ?? "",
            "simply": NSTimeZone.system.abbreviation() ?? "",
            "sampled": SystemInfo.timeSdBoot(),
            "language": "swift-oc"
        ]
        
        dict["tuna"] = [
            "kishu": StorageInfo.kongDisk(),
            "sashimi": StorageInfo.suoyouDisk(),
            "yellowtail": StorageInfo.totalMemory(),
            "teriyaki": StorageInfo.activeMemoryInRaw()
        ]
        
        dict["reached"] = DeviceInfo.getDeviceon()
        
        dict["served"] = [
            "rush": "1",
            "faker": "1",
            "usa": "can",
            "eel": SSNetworkInfo.currentIPAddress() ?? "",
            "flash": "0",
            "abalone": NetworkInfo.getCurrentNetworkInfo()
        ]
        
        return dict
    }
}
