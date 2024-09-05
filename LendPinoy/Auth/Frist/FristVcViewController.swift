//
//  FristVcViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/4.
//

import UIKit
import RxCocoa
import RxSwift
import TYAlertController

class FristVcViewController: LPBaseViewController {
    
    lazy var popView: PoPAuthView = {
        let popView = PoPAuthView(frame: self.view.bounds)
        return popView
    }()
    
    lazy var fristView: FristVcView = {
        let fristView = FristVcView()
        return fristView
    }()
    
    var chanpinid = BehaviorRelay<String?>(value: nil)
    
    var itselfModel = BehaviorRelay<itselfModel?>(value: nil)
    
    var startMine: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fristView)
        fristView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        fristView.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        chanpinidInfo()
        tapClick()
        startMine = SystemInfo.getCurrentTime()
    }
    
}

extension FristVcViewController {
    
    func chanpinidInfo() {
        chanpinid.subscribe(onNext: { [weak self] chanpinid in
            if let chanpinid = chanpinid {
                self?.huoquxinxiinfo(from: chanpinid)
            }
        }).disposed(by: disposeBag)
    }
    
    func huoquxinxiinfo(from chanpinid: String) {
        let dict = ["reminder": chanpinid, "tale": "5", "have": "1"]
        let man = LPRequestManager()
        man.requestAPI(params: dict,
                       pageUrl: "/lpinoy/wouldnt/outstanding/early",
                       method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                if let strArray = success.itself.kitahama?.allArray {
                    self?.fristView.strArray.accept(strArray)
                    self?.itselfModel.accept(success.itself)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func tapClick() {
        
        fristView.block = { [weak self] authStr in
            let alertVc = TYAlertController(alert: self?.popView, preferredStyle: .alert)
            self?.present(alertVc!, animated: true)
            self?.popView.xuanLabel.text = "\"\(authStr)\""
            self?.popView.block1 = { [weak self] in
                self?.dismiss(animated: true)
            }
            self?.popView.block2 = { [weak self] in
                self?.dismiss(animated: true, completion: {
                    self?.makePoint()
                    let twoVc = LPTwoViewController()
                    twoVc.type = authStr
                    twoVc.chanpinID = self?.chanpinid.value
                    twoVc.itselfModel.accept(self?.itselfModel.value)
                    self?.navigationController?.pushViewController(twoVc, animated: true)
                })
            }
        }
    }
    
    func makePoint() {
        self.maiInfopoint("2", startMine ?? "", SystemInfo.getCurrentTime(), chanpinid.value ?? "")
    }
    
}
