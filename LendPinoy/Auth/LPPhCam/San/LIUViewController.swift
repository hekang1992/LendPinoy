//
//  LIUViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/6.
//

import UIKit
import RxRelay

class LIUViewController: LPBaseViewController {
    
    var chanpinID = BehaviorRelay<String>(value: "")
    
    var addEb = BehaviorRelay<String>(value: "0")
    
    lazy var liuView: LPLIUView = {
        let liuView = LPLIUView()
        return liuView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeSs()
        ebInfo()
    }

}


extension LIUViewController {
    
    func makeSs() {
        view.addSubview(liuView)
        liuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        liuView.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
            LPTabBarManager.showTabBar()
        }
        
        liuView.tapBlock = { [weak self] btn, model in
            self?.view.endEditing(true)
            self?.genjuModelqutiaozhuan(from: model, anniu: btn)
        }
        
        liuView.comfirmblock = { [weak self] in
            
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
        man.requestAPI(params: ["collection": addEb.value], pageUrl: "/lpinoy/clothing/flakes/visitas", method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                if let modelArray = success.itself.crossing, let model1Array = modelArray.first?.crossing, let model2Array = modelArray.last?.crossing {
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
