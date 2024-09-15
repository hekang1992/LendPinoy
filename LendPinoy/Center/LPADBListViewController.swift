//
//  LPADBListViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/9.
//

import UIKit
import RxRelay

class LPADBListViewController: LPBaseViewController {
    
    lazy var listView: LPADBListView = {
        let listView = LPADBListView()
        return listView
    }()
    
    var reminder = BehaviorRelay<String>(value: "")
    
    var embarrassment = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addNavView(title: "Payment Methods")
        tapclick()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        huoquxinxi()
    }
    
}


extension LPADBListViewController {
    
    func tapclick() {
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(self.navView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        listView.adblock = { [weak self] in
            let bac = LIUViewController()
            bac.addEb.accept("1")
            bac.thorough.accept(self?.embarrassment.value ?? "")
            self?.navigationController?.pushViewController(bac, animated: true)
        }
        listView.adbcclock = { [weak self] ppd in
            let man = LPRequestManager()
            man.requestAPI(params: ["confirm": ppd, "thorough": self?.embarrassment.value ?? ""], pageUrl: "/lpinoy/waiting/having/kitchendad", method: .post) { [weak self] result in
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
        
    }
    
    func huoquxinxi() {
        let man = LPRequestManager()
        man.requestAPI(params: ["bab": "two", "adb": "1"], pageUrl: "/lpinoy/wisteriacoloured/acquaintance/fancy", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                if let modelArray = success.itself.dazed {
                    let sections = modelArray.map { model -> dazedModel in
                        let shuzus = model.delivery ?? []
                        return dazedModel(original: model, items: shuzus)
                    }
                    self?.listView.modeArray.accept(sections)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
}
