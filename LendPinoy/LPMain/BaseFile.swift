//
//  File.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import Foundation
import SnapKit
import Alamofire

let BASE_URL = "https://thriftplatinumlending.com/aceapi"

let MarketFresh_Font = "MarketFresh"
let MarketFreshBold_Font = "MarketFreshBold"


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








