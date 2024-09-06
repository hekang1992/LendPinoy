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
    }
}

extension SamViewController {
    
    func HuoQiInfo() {
        let man = LPRequestManager()
        man.requestAPI(params: ["upDone": "01", "reminder": chanpinID.value], pageUrl: "/lpinoy/nagare/bound/hideji", method: .post) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}
