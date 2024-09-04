//
//  LPSheBeiInfo.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit
import SystemServices
import KeychainAccess
import AdSupport
import DeviceKit
import SystemConfiguration.CaptiveNetwork

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

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
    
    static func getDeviceDescription() -> [String: Any] {
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
    
    static func getAppWifiSSIDInfo() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String],
              let interface = interfaces.first as CFString?,
              let info = CNCopyCurrentNetworkInfo(interface) as NSDictionary? else { return "" }
        return info["SSID"] as? String ?? ""
    }
    
    static func getAppWifiBSSIDInfo() -> String {
        guard let interfaces = CNCopySupportedInterfaces() as? [String],
              let interface = interfaces.first as CFString?,
              let info = CNCopyCurrentNetworkInfo(interface) as NSDictionary? else { return "" }
        return info["BSSID"] as? String ?? ""
    }
    
    static func isUsingProxy() -> String {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [AnyHashable: Any],
              let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.apple.com")! as CFURL, proxySettings as CFDictionary).takeRetainedValue() as? [[AnyHashable: Any]],
              let settings = proxies.first,
              let proxyType = settings[kCFProxyTypeKey] as? String else { return "0" }
        return proxyType == kCFProxyTypeNone as String ? "0" : "1"
    }
    
    static func isVPNConnected() -> Bool {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sa_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
    
    static func getCurrentWifiMac() -> String {
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
            "quench": getAppWifiSSIDInfo(),
            "miyajima": getAppWifiBSSIDInfo(),
            "aromas": getCurrentWifiMac(),
            "seared": getAppWifiSSIDInfo()
        ]
    }
}

class StorageInfo {
    
    static func freeDisk() -> String {
        return String(format: "%.2f", SystemServices.shared().longFreeDiskSpace)
    }
    
    static func allDisk() -> String {
        return String(format: "%.2f", SystemServices.shared().longDiskSpace)
    }
    
    static func totalMemory() -> String {
        return String(format: "%.0f", SystemServices.shared().totalMemory * 1024 * 1024)
    }
    
    static func activeMemoryInRaw() -> String {
        return String(format: "%.0f", SystemServices.shared().activeMemoryinRaw * 1024 * 1024)
    }
}

class SystemInfo {
    
    static func getLastTime() -> String {
        let loginTime = ProcessInfo.processInfo.systemUptime
        let timeDate = Date(timeIntervalSinceNow: -loginTime)
        return String(format: "%ld", Int(timeDate.timeIntervalSince1970 * 1000))
    }
    
    static func timeSinceDeviceBoot() -> String {
        return String(format: "%.0f", ProcessInfo.processInfo.systemUptime * 1000)
    }
    
    static func getCurrentTime() -> String {
        return String(Int64(Date().timeIntervalSince1970 * 1000))
    }
}

class SecurityInfo {
    
    static func isJailBreak() -> String {
        let jailbreakToolPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        return jailbreakToolPaths.contains { FileManager.default.fileExists(atPath: $0) } ? "1" : "0"
    }
}

class KeychainHelper {
    
    static func saveIDFVToKeychain() {
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        let keychain = Keychain(service: "com.LendPinoy.Ph")
        do {
            try keychain.set(idfv, key: "deviceIDFV")
        } catch {
            print("Error: \(error)")
        }
    }
    
    static func retrieveIDFVFromKeychain() -> String? {
        let keychain = Keychain(service: "com.LendPinoy.Ph")
        do {
            if let idfv = try keychain.get("deviceIDFV") {
                return idfv
            } else {
                saveIDFVToKeychain()
                return retrieveIDFVFromKeychain()
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
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
            "fish": "yu",
            "pigsy": "pid",
            "high": "180",
            "googs": "0",
            "lacquerware": SystemServices().charging ? 1 : 0
        ]
        
        dict["overdo"] = [
            "swift": "1",
            "drooling": KeychainHelper.retrieveIDFVFromKeychain() ?? "",
            "practically": DeviceInfo.getIDFA(),
            "aromas": NetworkInfo.getCurrentWifiMac(),
            "faker": Device.current.systemName ?? "",
            "extending": SystemInfo.getCurrentTime(),
            "tsujitomi": NetworkInfo.isUsingProxy(),
            "delight": NetworkInfo.isVPNConnected(),
            "swiftcode": "1",
            "facebool": SystemInfo.getCurrentTime(),
            "agape": SecurityInfo.isJailBreak(),
            "is_simulator": DeviceInfo.isSimulator(),
            "json": "1",
            "melts": SystemServices().language ?? "",
            "octopus": SystemServices().carrierName ?? "",
            "balls": NetworkReachability.shared.netType ?? "",
            "simply": NSTimeZone.system.abbreviation() ?? "",
            "sampled": SystemInfo.timeSinceDeviceBoot(),
            "language": "swift-oc"
        ]
        
        dict["tuna"] = [
            "kishu": StorageInfo.freeDisk(),
            "sashimi": StorageInfo.allDisk(),
            "yellowtail": StorageInfo.totalMemory(),
            "teriyaki": StorageInfo.activeMemoryInRaw()
        ]
        
        dict["reached"] = DeviceInfo.getDeviceDescription()
        
        dict["served"] = [
            "rush": "1",
            "faker": "1",
            "usa": "0",
            "eel": SSNetworkInfo.currentIPAddress() ?? "",
            "flash": "0",
            "abalone": NetworkInfo.getCurrentNetworkInfo()
        ]
        
        return dict
    }
}
