//
//  File.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import Foundation
import SnapKit
import Alamofire
import Toaster

let BASE_URL = "https://thriftplatinumlending.com/aceapi"

let regular_MarketFresh = "MarketFresh"
let bold_MarketFresh = "MarketFreshBold"


let LP_LOGIN = "LP_LOGIN"
let LP_SESSIONID = "LP_SESSIONID"

let MAIDIAN1 = "MAIDIAN1"

var IS_LOGIN: Bool {
    if let sessionID = UserDefaults.standard.object(forKey: LP_SESSIONID) as? String {
        return !sessionID.isEmpty
    } else {
        return false
    }
}

extension Double {
    func lpix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension CGFloat {
    func lpix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension Int {
    func lpix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * SCREEN_WIDTH)
    }
}

extension UILabel {
    static func buildLabel(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textAlignment = textAlignment
        label.backgroundColor = UIColor.clear
        label.textColor = textColor
        label.font = font
        return label
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            self.init(white: 0.0, alpha: 0.0)
            return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}








class StatusHeightManager {
    
    static var statusBarHeight:CGFloat {
        var height: CGFloat = 20.0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            height = window.safeAreaInsets.top
        }
        return height
    }
    
    static var navigationBarHeight:CGFloat {
        var navBarHeight: CGFloat = 64.0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            let safeTop = window.safeAreaInsets.top
            navBarHeight = safeTop > 0 ? (safeTop + 44) : 44
        }
        return navBarHeight
    }
    
    static var safeAreaBottomHeight:CGFloat {
        var safeHeight: CGFloat = 0;
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window!!
            safeHeight = window.safeAreaInsets.bottom
        }
        return safeHeight
    }
    
    static var tabBarHeight: CGFloat {
        return 49 + safeAreaBottomHeight
    }
}

class ToastUtility {
    static func showToast(message: String) {
        let toast = Toast(text: message, duration: Delay.short)
        toast.show()
    }
}

