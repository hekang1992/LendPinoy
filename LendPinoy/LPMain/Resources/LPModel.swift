//
//  LPModel.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import Foundation
import SwiftyJSON
import Differentiator

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
    var confirm: String?
    var yokohama: String?
    var erase: String?
    var joy: joyModel?
    var purse: purseModel?
    var forests: forestsModel?
    var fast_list: forestsModel?
    var overdue: overdueModel?
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
        self.confirm = json["confirm"].stringValue
        self.yokohama = json["yokohama"].stringValue
        self.erase = json["erase"].stringValue
        self.joy = joyModel(json: json["joy"])
        self.purse = purseModel(json: json["purse"])
        self.forests = forestsModel(json: json["forests"])
        self.fast_list = forestsModel(json: json["fast_list"])
        self.researching = researchingModel(json: json["researching"])
        self.kitahama = kitahamaModel(json: json["kitahama"])
        self.classical = classicalModel(json: json["classical"])
        self.admit = admitModel(json: json["admit"])
        self.overdue = overdueModel(json: json["overdue"])
        self.crossing = json["crossing"].arrayValue.map {
            crossingModel(json: $0)
        }
        self.dazed = json["dazed"].arrayValue.map {
            dazedModel(json: $0)
        }
    }
}

class overdueModel {
    var delivery: [deliveryModel]?
    init(json: JSON) {
        self.delivery = json["delivery"].arrayValue.map {
            deliveryModel(json: $0)
        }
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
        self.dazed = json["dazed"].arrayValue.map {
            dazedModel(json: $0)
        }
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
    var replaced: String?
    var shrines: String?
    var notictColor: String?
    var insist: String?
    var decline: String?
    var culture: String?
    var strangest: String?
    var btnText: String?
    var heike: String?
    var endless: String?
    var suffers: String?
    var loanText: String?
    var precisely: String?
    var mess: String?
    var calling: String?
    var btnCollor: String?
    var france: String?
    var delivery: [deliveryModel]?
    var kaiseki: [silentModel]?
    var dazed: [dazedModel]?
    init(json: JSON) {
        self.france = json["france"].stringValue
        self.btnCollor = json["btnCollor"].stringValue
        self.calling = json["calling"].stringValue
        self.btnText = json["btnText"].stringValue
        self.mess = json["mess"].stringValue
        self.precisely = json["precisely"].stringValue
        self.shrines = json["shrines"].stringValue
        self.notictColor = json["notictColor"].stringValue
        self.insist = json["insist"].stringValue
        self.decline = json["decline"].stringValue
        self.culture = json["culture"].stringValue
        self.strangest = json["strangest"].stringValue
        self.heike = json["heike"].stringValue
        self.endless = json["endless"].stringValue
        self.suffers = json["suffers"].stringValue
        self.loanText = json["loanText"].stringValue
        self.hesitantly = json["hesitantly"].stringValue
        self.quench = json["quench"].stringValue
        self.smiled = json["smiled"].stringValue
        self.restaurants = json["restaurants"].stringValue
        self.uncle = json["uncle"].stringValue
        self.panicked = json["panicked"].stringValue
        self.relationText = json["relationText"].stringValue
        self.replaced = json["replaced"].stringValue
        self.delivery = json["delivery"].arrayValue.map {
            deliveryModel(json: $0)
        }
        self.kaiseki = json["kaiseki"].arrayValue.map {
            silentModel(json: $0)
        }
        self.dazed = json["dazed"].arrayValue.map {
            dazedModel(json: $0)
        }
    }
    
    required init(original: dazedModel, items: [deliveryModel]) {
        self.delivery = items
    }
    
}

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
        self.silent = json["silent"].arrayValue.map {
            silentModel(json: $0)
        }
        self.crossing = json["crossing"].arrayValue.map {
            crossingModel(json: $0)
        }
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
        self.silent = json["silent"].arrayValue.map {
            silentModel(json: $0)
        }
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
    var confirm: String?
    var ours: String?
    var drank: String?
    var daze: String?
    var endless: String?
    var shrines: String?
    var amountMax: String?
    var afraid: String?
    var husband: String?
    var frown: String?
    init(json: JSON) {
        self.frown = json["frown"].stringValue
        self.payment = json["payment"].stringValue
        self.fine = json["fine"].stringValue
        self.fortnight = json["fortnight"].stringValue
        self.confirm = json["confirm"].stringValue
        self.ours = json["ours"].stringValue
        self.hesitantly = json["hesitantly"].stringValue
        self.daze = json["daze"].stringValue
        self.drank = json["drank"].stringValue
        self.endless = json["endless"].stringValue
        self.shrines = json["shrines"].stringValue
        self.amountMax = json["amountMax"].stringValue
        self.afraid = json["afraid"].stringValue
        self.husband = json["husband"].stringValue
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

extension dazedModel: SectionModelType {
    var items: [deliveryModel] {
        return self.delivery!
    }
}

