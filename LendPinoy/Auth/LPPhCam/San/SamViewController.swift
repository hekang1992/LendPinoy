//
//  SamViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/6.
//

import UIKit
import RxRelay

class SamViewController: LPBaseViewController {
    
    var chanpinID = BehaviorRelay<String>(value: "")
    
    var modelArray = BehaviorRelay<[crossingModel]?>(value: [])
    
    var modelCyArray = BehaviorRelay<[dazedModel]?>(value: [])
    
    lazy var yiView: YIBanView = {
        let yiView = YIBanView()
        yiView.navView.titleLabel.text = "Personal Information"
        return yiView
    }()
    
    var st: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(yiView)
        yiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        yiView.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
            LPTabBarManager.showTabBar()
        }
        st = SystemInfo.getCurrentTime()
        HuoQiInfo()
        tapClick()
    }
}

extension SamViewController {
    
    func HuoQiInfo() {
        let man = LPRequestManager()
        man.requestAPI(params: ["upDone": "01", "reminder": chanpinID.value], pageUrl: "/lpinoy/nagare/bound/hideji", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                if let modelArray = success.itself.crossing {
                    self?.modelArray.accept(modelArray)
                    self?.yiView.modelArray.accept(modelArray)
                    self?.yiView.tableView.reloadData()
                }
                break
            case .failure(let failure):
                print("failure:\(failure)")
                break
            }
        }
    }
    
    func tapClick() {
        yiView.tapBlock = { [weak self] btn, model in
            self?.view.endEditing(true)
            self?.genjuModelqutiaozhuan(from: model, anniu: btn)
        }
        
        yiView.comfirmblock = { [weak self] in
            self?.comInfo()
        }
    }
    
    func comInfo() {
        var dict: [String: Any]?
        if let modelArray = self.modelArray.value {
            dict = modelArray.reduce(into: [String: Any](), { partialResult, model in
                
                if let hitch = model.hitch {
                    if model.photo == "pointing1" || model.photo == "pointing4" {
                        partialResult[hitch] = model.separately
                    }else {
                        partialResult[hitch] = model.completely
                    }
                }
            })
        }
        dict?["seated"] = String("value")
        dict?["reminder"] = chanpinID.value
        
        if let redict = dict {
            let man = LPRequestManager()
            man.uploadDataAPI(params: redict, pageUrl: "/lpinoy/tastes/namii/radiating", method: .post) { [weak self] result in
                switch result {
                case .success(_):
                    self?.maiInfopoint("5", self?.st ?? "", SystemInfo.getCurrentTime(), self?.chanpinID.value ?? "")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if let chanpinID = self?.chanpinID.value {
                            self?.chanpinxiangqingyemian(chanpinID)
                        }
                    }
                    break
                case .failure(let failure):
                    print("failure:\(failure)")
                    break
                }
            }
        }
    }
    
    func genjuModelqutiaozhuan(from model: crossingModel, anniu: UIButton) {
        let pigs = model.photo ?? ""
        print("pigs:\(pigs)")
        if pigs == "pointing1" {
            if let silent = model.silent {
                let modelArray = LPXuanZeManager.oneModel(sourceArr: silent, level: 1)
                TanchuXuanZeMananger.showOnePicker(from: .province, model: model, button: anniu, dataArray: modelArray)
            }
        }else if pigs == "pointing3" {
            getPhCy(from: model, anniu: anniu)
        }else if pigs == "pointing4" {
            if let silent = model.silent {
                let modelArray = LPXuanZeManager.oneModel(sourceArr: silent, level: 2)
                TanchuXuanZeMananger.showOnePicker(from: .city, model: model, button: anniu, dataArray: modelArray)
            }
        }else {
            
        }
    }
    
    func getPhCy(from model: crossingModel, anniu: UIButton) {
        if let modelCyArray = modelCyArray.value, modelCyArray.count > 0 {
            let dataArray = LPXuanZeManager.threemodel(from: modelCyArray, level: 3)
            TanchuXuanZeMananger.showOnePicker(from: .area, model: model, button: anniu, dataArray: dataArray)
        } else {
            let man = LPRequestManager()
            man.requestAPI(params: ["cc": "1", "php": "four"], pageUrl: "/lpinoy/called/herin/different", method: .get) { [weak self] result in
                switch result {
                case .success(let success):
                    if let modelArray = success.itself.dazed {
                        self?.modelCyArray.accept(modelArray)
                        let dataArray = LPXuanZeManager.threemodel(from: modelArray, level: 3)
                        TanchuXuanZeMananger.showOnePicker(from: .area, model: model, button: anniu, dataArray: dataArray)
                    }
                    break
                case .failure(let failure):
                    print("failure:\(failure)")
                    break
                }
            }
        }
        
    }
}
