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
    
    lazy var yiView: YIBanView = {
        let yiView = YIBanView()
        return yiView
    }()
    
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
    }
    
    func genjuModelqutiaozhuan(from model: crossingModel, anniu: UIButton) {
        let pigs = model.photo ?? ""
        print("pigs:\(pigs)")
        if pigs == "pointing1" {
            
        }else if pigs == "pointing3" {
            
        }else if pigs == "pointing4" {
            
        }else {
            
        }
    }
    
}
