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

class BaseModel {
    var hitch: Int?
    var frown: String?
    var itself: itselfModel
    init(json: JSON) {
        self.hitch = json["hitch"].intValue
        self.frown = json["frown"].stringValue
        let itselfJson = json["itself"]
        self.itself = itselfModel(json: itselfJson)
    }
}

class itselfModel {
    var ordered: String?
    var moist: String?
    var payment: String?
    var ate: String?
    var quench: String?
    var attending: String?
    var encouragingly: String?
    var joy: joyModel?
    var purse: purseModel?
    var forests: forestsModel?
    var researching: researchingModel?
    var kitahama: kitahamaModel?
    var classical: classicalModel?
    var admit: admitModel?
    var crossing: [crossingModel]?
    var dazed: [dazedModel]?
    init(json: JSON) {
        self.ordered = json["ordered"].stringValue
        self.moist = json["moist"].stringValue
        self.payment = json["payment"].stringValue
        self.ate = json["ate"].stringValue
        self.quench = json["quench"].stringValue
        self.attending = json["attending"].stringValue
        self.encouragingly = json["encouragingly"].stringValue
        self.joy = joyModel(json: json["joy"])
        self.purse = purseModel(json: json["purse"])
        self.forests = forestsModel(json: json["forests"])
        self.researching = researchingModel(json: json["researching"])
        self.kitahama = kitahamaModel(json: json["kitahama"])
        self.classical = classicalModel(json: json["classical"])
        self.admit = admitModel(json: json["admit"])
        self.crossing = json["crossing"].arrayValue.map({ json in
            crossingModel(json: json)
        })
        self.dazed = json["dazed"].arrayValue.map({ json in
            dazedModel(json: json)
        })
    }
}

class admitModel {
    var shocking: String?
    init(json: JSON) {
        self.shocking = json["shocking"].stringValue
    }
}

class joyModel {
    var dazed: [dazedModel]?
    init(json: JSON) {
        self.dazed = json["dazed"].arrayValue.map({ json in
            dazedModel(json: json)
        })
    }
}

class dazedModel {
    var hesitantly: String?
    var quench: String?
    var smiled: String?
    var restaurants: String?
    var uncle: String?
    var panicked: String?
    var relationText: String?
    var kaiseki: [silentModel]?
    var dazed: [dazedModel]?
    init(json: JSON) {
        self.hesitantly = json["hesitantly"].stringValue
        self.quench = json["quench"].stringValue
        self.smiled = json["smiled"].stringValue
        self.restaurants = json["restaurants"].stringValue
        self.uncle = json["uncle"].stringValue
        self.panicked = json["panicked"].stringValue
        self.relationText = json["relationText"].stringValue
        self.kaiseki = json["kaiseki"].arrayValue.map({ json in
            silentModel(json: json)
        })
        self.dazed = json["dazed"].arrayValue.map({ json in
            dazedModel(json: json)
        })
    }
}

var smiled: String?
var restaurants: String?
var uncle: String?
var panicked: String?
var kaiseki: silentModel?

class crossingModel {
    var readily: String?
    var met: String?
    var glued: String?
    var hitch: String?
    var photo: String?
    var completely: String?
    var separately: String?
    var silent: [silentModel]?
    var crossing: [crossingModel]?
    init(json: JSON) {
        self.readily = json["readily"].stringValue
        self.met = json["met"].stringValue
        self.glued = json["glued"].stringValue
        self.hitch = json["hitch"].stringValue
        self.photo = json["photo"].stringValue
        self.completely = json["completely"].stringValue
        self.separately = json["separately"].stringValue
        self.silent = json["silent"].arrayValue.map({ json in
            silentModel(json: json)
        })
        self.crossing = json["crossing"].arrayValue.map({ json in
            crossingModel(json: json)
        })
    }
}

class silentModel {
    var quench: String?
    var separately: String?
    var crystal: String?
    var silent: [silentModel]?
    init(json: JSON) {
        self.quench = json["quench"].stringValue
        self.separately = json["separately"].stringValue
        self.crystal = json["crystal"].stringValue
        self.silent = json["silent"].arrayValue.map({ json in
            silentModel(json: json)
        })
    }
}

class classicalModel {
    var order: String?
    var payment: String?
    var became: String?
    init(json: JSON) {
        self.order = json["order"].stringValue
        self.payment = json["payment"].stringValue
        self.became = json["became"].stringValue
    }
}

class researchingModel {
    var exchanged: String?
    init(json: JSON) {
        self.exchanged = json["exchanged"].stringValue
    }
}

class purseModel {
    var separately: String?
    var delivery: [deliveryModel]?
    init(json: JSON) {
        self.separately = json["separately"].stringValue
        self.delivery = json["delivery"].arrayValue.map { deliveryModel(json: $0) }
    }
}

class forestsModel {
    var separately: String?
    var delivery: [deliveryModel]?
    init(json: JSON) {
        self.separately = json["separately"].stringValue
        self.delivery = json["delivery"].arrayValue.map { deliveryModel(json: $0) }
    }
}

class deliveryModel {
    var payment: String?
    var fine: String?
    var fortnight: String?
    var hesitantly: String?
    init(json: JSON) {
        self.payment = json["payment"].stringValue
        self.fine = json["fine"].stringValue
        self.fortnight = json["fortnight"].stringValue
        self.hesitantly = json["hesitantly"].stringValue
    }
}


class kitahamaModel {
    var primaryArray: [String]
    var secondaryArray: [String]
    var allArray: [String]
    init(json: JSON) {
        self.primaryArray = json[0].arrayValue.map { $0.stringValue }
        self.secondaryArray = json[1].arrayValue.map { $0.stringValue }
        self.allArray = self.primaryArray + self.secondaryArray
    }
}
