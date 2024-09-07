//
//  LPHFViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/7.
//

import UIKit
import RxRelay

class LPHFViewController: LPBaseViewController {
    
    lazy var hfView: LPHFView = {
        let hfView = LPHFView()
        return hfView
    }()
    
    var lianjie = BehaviorRelay<String>(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(hfView)
        hfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tapClick()
        jiazaiUrl()
    }

}


extension LPHFViewController {
    
    func jiazaiUrl() {
        self.hfView.hwView.load(URLRequest(url: URL(string: lianjie.value.replacingOccurrences(of: " ", with: "%20"))!))
    }
    
    func tapClick() {
        hfView.navView.block = { [weak self] in
            guard let self = self else { return }
            if self.hfView.hwView.canGoBack {
                self.hfView.hwView.goBack()
            }else {
                self.gooneVc()
            }
            
        }
        
        hfView.guanbiBlock = { [weak self] in
            self?.gooneVc()
        }
        
        hfView.bugPointBlock = { [weak self] pro, st in
            self?.maiInfopoint("10", st, SystemInfo.getCurrentTime(), pro)
        }
        
        hfView.qunaliUrlBlock = { [weak self] lj in
            self?.genJuUrlPush(form: lj)
        }
        
    }
    
    func gooneVc() {
        LPTabBarManager.showTabBar()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
