//
//  LPModel.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
//

import Foundation
import SwiftyJSON

class DingModel: NSObject {
    var mizugashi: String?
    var dessert: String?
    var also: String?
    var conversation: String?
    var season: String?
    var turnip: String?
    var lightly: String?
    var spice: Double = 0.00
    var shichimi: Double = 0.00
}

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
    let ordered: String?
    let moist: String?
    let payment: String?
    let ate: String?
    let quench: String?
    let attending: String?
    let encouragingly: String?
    let purse: purseModel?
    let forests: forestsModel?
    let researching: researchingModel?
    let kitahama: kitahamaModel?
    let classical: classicalModel?
    init(json: JSON) {
        self.ordered = json["ordered"].stringValue
        self.moist = json["moist"].stringValue
        self.payment = json["payment"].stringValue
        self.ate = json["ate"].stringValue
        self.quench = json["quench"].stringValue
        self.attending = json["attending"].stringValue
        self.encouragingly = json["encouragingly"].stringValue
        self.purse = purseModel(json: json["purse"])
        self.forests = forestsModel(json: json["forests"])
        self.researching = researchingModel(json: json["researching"])
        self.kitahama = kitahamaModel(json: json["kitahama"])
        self.classical = classicalModel(json: json["classical"])
    }
}

struct classicalModel {
    let order: String?
    let payment: String?
    let became: String?
    init(json: JSON) {
        self.order = json["order"].stringValue
        self.payment = json["payment"].stringValue
        self.became = json["became"].stringValue
    }
}

struct researchingModel {
    let exchanged: String?
    init(json: JSON) {
        self.exchanged = json["exchanged"].stringValue
    }
}

struct purseModel {
    let separately: String?
    let delivery: [deliveryModel]?
    init(json: JSON) {
        self.separately = json["separately"].stringValue
        self.delivery = json["delivery"].arrayValue.map { deliveryModel(json: $0) }
    }
}

struct forestsModel {
    let separately: String?
    let delivery: [deliveryModel]?
    init(json: JSON) {
        self.separately = json["separately"].stringValue
        self.delivery = json["delivery"].arrayValue.map { deliveryModel(json: $0) }
    }
}

struct deliveryModel {
    let payment: String?
    let fine: String?
    let fortnight: String?
    let hesitantly: String?
    init(json: JSON) {
        self.payment = json["payment"].stringValue
        self.fine = json["fine"].stringValue
        self.fortnight = json["fortnight"].stringValue
        self.hesitantly = json["hesitantly"].stringValue
    }
}


struct kitahamaModel {
    let primaryArray: [String]
    let secondaryArray: [String]
    let allArray: [String]
    init(json: JSON) {
        self.primaryArray = json[0].arrayValue.map { $0.stringValue }
        self.secondaryArray = json[1].arrayValue.map { $0.stringValue }
        self.allArray = self.primaryArray + self.secondaryArray
    }
}
