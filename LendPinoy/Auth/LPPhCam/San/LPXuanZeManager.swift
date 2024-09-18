//
//  LPXuanZeManager.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/7.
//

import UIKit
import BRPickerView
import ContactsUI
import Contacts

typealias CCompletion = ((Bool) -> Void)

class LPXuanZeManager: NSObject {
    static func oneModel(sourceArr: [Any], level: Int) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        func process(_ array: [Any], level: Int) {
            guard level > 0 else { return }
            for item in array {
                if let pDic = item as? silentModel {
                    let pModel = BRProvinceModel()
                    pModel.name = pDic.quench
                    pModel.code = pDic.separately
                    pModel.index = array.firstIndex { $0 as AnyObject === pDic as AnyObject } ?? 0
                    result.append(pModel)
                } else if let nestedArray = item as? [Any] {
                    process(nestedArray, level: level - 1)
                }
            }
        }
        process(sourceArr, level: level)
        return result
    }
    
    static func twoModel(sourceArr: [Any], level: Int) -> [BRProvinceModel] {
        guard level > 0, !sourceArr.isEmpty else {
            return []
        }

        func processCityDictionary(_ dict: silentModel) -> BRCityModel {
            let cityModel = BRCityModel()
            cityModel.code = dict.separately
            cityModel.name = dict.quench
            cityModel.index = (dict.silent ?? []).firstIndex(where: { $0 as AnyObject === dict as AnyObject }) ?? 0
            return cityModel
        }

        func processProvinceDictionary(_ dict: silentModel) -> BRProvinceModel {
            let provinceModel = BRProvinceModel()
            provinceModel.code = dict.separately
            provinceModel.name = dict.quench
            provinceModel.index = (sourceArr as? [silentModel] ?? []).firstIndex(where: { $0 as AnyObject === dict as AnyObject }) ?? 0
            if let cityList = dict.silent {
                provinceModel.citylist = cityList.map { cityDict in
                    return processCityDictionary(cityDict)
                }.compactMap { $0 }
            }
            return provinceModel
        }

        var resultArr = [BRProvinceModel]()
        for item in sourceArr {
            guard let dict = item as? silentModel else {
                continue
            }
            let model = processProvinceDictionary(dict)
            resultArr.append(model)
        }
        return resultArr
    }
    
    static func threemodel(from dataArr: [Any], level: Int) -> [BRProvinceModel] {
        guard level > 0, !dataArr.isEmpty else {
            return []
        }

        func processAreaDictionary(_ dict: dazedModel) -> BRAreaModel {
            let areaModel = BRAreaModel()
            areaModel.code = dict.hesitantly
            areaModel.name = dict.quench
            areaModel.index = (dict.dazed ?? []).firstIndex(where: { $0 as AnyObject === dict as AnyObject }) ?? 0
            return areaModel
        }
        
        func processCityDictionary(_ dict: dazedModel) -> BRCityModel {
            let cityModel = BRCityModel()
            cityModel.code = dict.hesitantly
            cityModel.name = dict.quench
            cityModel.index = (dict.dazed ?? []).firstIndex(where: { $0 as AnyObject === dict as AnyObject }) ?? 0
            if let areaList = dict.dazed {
                cityModel.arealist = areaList.map { areaDict in
                    return processAreaDictionary(areaDict)
                }.compactMap { $0 }
            }
            
            return cityModel
        }
        
        func processProvinceDictionary(_ dict: dazedModel) -> BRProvinceModel {
            let provinceModel = BRProvinceModel()
            provinceModel.code = dict.hesitantly
            provinceModel.name = dict.quench
            provinceModel.index = (dataArr as? [dazedModel] ?? []).firstIndex(where: { $0 as AnyObject === dict as AnyObject }) ?? 0
            if let cityList = dict.dazed {
                provinceModel.citylist = cityList.map { cityDict in
                    return processCityDictionary(cityDict)
                }.compactMap { $0 }
            }
            return provinceModel
        }
        
        var resultArr = [BRProvinceModel]()
        for item in dataArr {
            guard let dict = item as? dazedModel else {
                continue
            }
            let model = processProvinceDictionary(dict)
            resultArr.append(model)
        }
        
        return resultArr
    }
    
}

class TanchuXuanZeMananger: NSObject {
    static func showOnePicker(from mode: BRAddressPickerMode, model: crossingModel, button: UIButton, dataArray: [BRProvinceModel]) {
        let addressPicker = BRAddressPickerView()
        addressPicker.title = model.readily ?? ""
        addressPicker.pickerMode = mode
        addressPicker.selectIndexs = [0, 0, 0]
        addressPicker.dataSourceArr = dataArray
        addressPicker.resultBlock = { province, city, area in
            let (address, code) = self.formatAddress(province: province, city: city, area: area)
            model.completely = address
            model.separately = code
            button.setTitle(address, for: .normal)
            button.setTitleColor(UIColor(hex: "#2CD7BB"), for: .normal)
        }
        addressPicker.pickerStyle = createPickerStyle()
        addressPicker.show()
    }
    
    static func showCPicker(from mode: BRAddressPickerMode, model: dazedModel, label: UILabel, dataArray: [BRProvinceModel], completion: @escaping (String, String) -> Void) {
        let addressPicker = BRAddressPickerView()
        addressPicker.title = model.panicked ?? ""
        addressPicker.pickerMode = mode
        addressPicker.selectIndexs = [0, 0, 0]
        addressPicker.dataSourceArr = dataArray
        addressPicker.resultBlock = { province, city, area in
            let (address, code) = self.formatAddress(province: province, city: city, area: area)
            model.panicked = address
            model.smiled = code
            label.text = address
            completion(address, code)
        }
        addressPicker.pickerStyle = createPickerStyle()
        addressPicker.show()
    }
    
    private static func formatAddress(province: BRProvinceModel?, city: BRCityModel?, area: BRAreaModel?) -> (String, String) {
        let provinceName = province?.name ?? ""
        let cityName = city?.name ?? ""
        let areaName = area?.name ?? ""
        var address = provinceName
        var code = province?.code ?? ""
        if !cityName.isEmpty {
            address += "|\(cityName)"
            code += "|\(city?.code ?? "")"
        }
        if !areaName.isEmpty {
            address += "|\(areaName)"
            code += "|\(area?.code ?? "")"
        }
        return (address, code)
    }
    
    private static func createPickerStyle() -> BRPickerStyle {
        let style = BRPickerStyle()
        style.pickerColor = .white
        style.pickerTextFont = UIFont(name: bold_MarketFresh, size: 24)
        style.selectRowTextColor = UIColor(hex: "#2CD7BB")
        return style
    }
}

class CCompletionManager: NSObject,CNContactPickerDelegate {
    static func ccPersion(completion: @escaping CCompletion) {
        let cnstore = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completion(true)
        case .notDetermined:
            cnstore.requestAccess(for: .contacts, completionHandler: { (granted, error) in
                DispatchQueue.main.async {
                    completion(granted)
                }
            })
        case .denied, .restricted:
            completion(false)
        default:
            break
        }
    }
}
