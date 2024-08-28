//
//  LPModel.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import Foundation
import SwiftyJSON


struct BaseModel {
    let hitch: Int?
    let frown: String?
    let itself: itselfModel
    
    init(json: JSON) {
        self.hitch = json["hitch"].intValue
        self.frown = json["frown"].stringValue
        let itselfJson = json["itself"]
        self.itself = itselfModel(json: itselfJson)
    }
}

struct itselfModel {
    let fade: String?
    init(json: JSON) {
        self.fade = json["fade"].stringValue
    }
}
