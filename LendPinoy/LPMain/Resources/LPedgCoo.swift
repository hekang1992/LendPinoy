//
//  LPedgCoo.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/24.
//

import Foundation
import UIKit
import KeychainAccess
import SystemServices

class SystemInfo {
    
    static func getLastTime() -> String {
        let loginTime = ProcessInfo.processInfo.systemUptime
        let timeDate = Date(timeIntervalSinceNow: -loginTime)
        return String(format: "%ld", Int(timeDate.timeIntervalSince1970 * 1000))
    }
    
    static func timeSdBoot() -> String {
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
        let cc = UIDevice.current
        guard let idfv = cc.identifierForVendor?.uuidString else {
            return
        }
        let keychain = Keychain(service: "com.LendPinoy.Ph")
        do {
            try keychain.set(idfv, key: "deviceIDFV")
        } catch {
            print("Error: \(error)")
        }
    }
    
    static func retrieveidfv() -> String? {
        let keychain = Keychain(service: "com.LendPinoy.Ph")
        do {
            if let idfv = try keychain.get("deviceIDFV") {
                return idfv
            } else {
                saveIDFVToKeychain()
                return retrieveidfv()
            }
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}

class StorageInfo {
    
    static func kongDisk() -> String {
        return String(format: "%.2lld", SystemServices.shared().longFreeDiskSpace)
    }
    
    static func suoyouDisk() -> String {
        return String(format: "%.2lld", SystemServices.shared().longDiskSpace)
    }
    
    static func totalMemory() -> String {
        return String(format: "%.0f", SystemServices.shared().totalMemory * 1024 * 1024)
    }
    
    static func activeMemoryInRaw() -> String {
        return String(format: "%.0f", SystemServices.shared().activeMemoryinRaw * 1024 * 1024)
    }
}
