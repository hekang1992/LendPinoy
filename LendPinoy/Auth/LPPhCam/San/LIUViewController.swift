//
//  LIUViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/6.
//

import UIKit
import RxRelay

class LIUViewController: LPBaseViewController {
    
    var chanpinID = BehaviorRelay<String>(value: "")
    
    var addEb = BehaviorRelay<String>(value: "0")
    
    var thorough = BehaviorRelay<String>(value: "")
    
    var model1Array = BehaviorRelay<[crossingModel]?>(value: [])
    
    var model2Array = BehaviorRelay<[crossingModel]?>(value: [])
    
    var liuTi: String?
    
    lazy var liuView: LPLIUView = {
        let liuView = LPLIUView()
        return liuView
    }()

    var becameinfo = BehaviorRelay<String>(value: "1")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeSs()
        ebInfo()
        liuTi = SystemInfo.getCurrentTime()
    }

}


extension LIUViewController {
    
    func makeSs() {
        view.addSubview(liuView)
        liuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        liuView.navView.block = { [weak self] in
            if let navigationController = self?.navigationController {
                if let targetViewController = navigationController.viewControllers.first(where: { $0 is LPOrderListViewController }) {
                    navigationController.popToViewController(targetViewController, animated: true)
                } else {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
        liuView.tapBlock = { [weak self] btn, model in
            self?.view.endEditing(true)
            self?.genjuModelqutiaozhuan(from: model, anniu: btn)
        }
        
        liuView.becameInfoBlock = { [weak self] becameinfo in
            self?.becameinfo.accept(becameinfo)
            print("becameinfo>>>>>\(self?.becameinfo.value ?? "")")
        }
        
        liuView.comfirmblock = { [weak self] in
            var dict: [String: Any]?
            dict?["daishiro"] = "var"
            dict?["frown"] = "0"
            dict?["fera"] = "1"
            dict?["reminder"] = self?.chanpinID.value
            if self?.becameinfo.value == "1" {
                if let model1Array = self?.model1Array {
                    dict = model1Array.value?.reduce(into: [String: Any](), { partialResult, model in
                        if model.photo == "pointing1" || model.photo == "pointing4" {
                            partialResult[model.hitch!] = model.separately
                        }else {
                            partialResult[model.hitch!] = model.completely
                        }
                    })
                    dict?["became"] = "1"
                }
            }else {
                if let model2Array = self?.model2Array {
                    dict = model2Array.value?.reduce(into: [String: Any](), { partialResult, model in
                        if model.photo == "pointing1" || model.photo == "pointing4" {
                            partialResult[model.hitch!] = model.separately
                        }else {
                            partialResult[model.hitch!] = model.completely
                        }
                    })
                    dict?["became"] = "2"
                }
            }
            if let dict = dict {
                let man = LPRequestManager()
                man.requestAPI(params: dict, pageUrl: "/lpinoy/toher/still/touristy", method: .post) { [weak self] result in
                    switch result {
                    case .success(let success):
                        if self?.addEb.value == "1" {
                            self?.chaaccn(from: success.itself)
                        } else {
                            self?.maiInfopoint("8", self?.liuTi ?? "", SystemInfo.getCurrentTime(), self?.chanpinID.value ?? "")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self?.chanpinxiangqingyemian(self?.chanpinID.value ?? "")
                            }
                        }
                        break
                    case .failure(_):
                        break
                    }
                }
            }
        }
        
    }
    
    func chaaccn(from model: itselfModel) {
        let man = LPRequestManager()
        man.requestAPI(params: ["confirm": model.confirm ?? "", "thorough": thorough.value], pageUrl: "/lpinoy/waiting/having/kitchendad", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                let model = success.itself
                if let yokohama = model.yokohama, !yokohama.isEmpty {
                    self?.genJuUrlPush(form: yokohama)
                }else {
                    self?.navigationController?.popViewController(animated: true)
                }
                break
            case .failure(_):
                break
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
            
        }else if pigs == "pointing4" {
            if let silent = model.silent {
                let modelArray = LPXuanZeManager.twoModel(sourceArr: silent, level: 2)
                TanchuXuanZeMananger.showOnePicker(from: .city, model: model, button: anniu, dataArray: modelArray)
            }
        }else {
            
        }
    }
    
    func ebInfo() {
        let man = LPRequestManager()
        man.requestAPI(params: ["collection": addEb.value, "harumi": "ipo"], pageUrl: "/lpinoy/clothing/flakes/visitas", method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                if let modelArray = success.itself.crossing, let model1Array = modelArray.first?.crossing, let model2Array = modelArray.last?.crossing {
                    self.model1Array.accept(model1Array)
                    self.model2Array.accept(model2Array)
                    self.liuView.modelArray.accept(model1Array)
                    self.liuView.model1Array.accept(model1Array)
                    self.liuView.model2Array.accept(model2Array)
                    self.liuView.tableView.reloadData()
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}
