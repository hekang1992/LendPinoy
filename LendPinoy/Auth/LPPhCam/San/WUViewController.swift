//
//  WUViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/6.
//

import UIKit
import RxRelay

class WUViewController: LPBaseViewController {

    var chanpinID = BehaviorRelay<String>(value: "")
    
    lazy var tpView: LPThreePView = {
        let tpView = LPThreePView()
        tpView.navView.titleLabel.text = "Contact Information"
        return tpView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeuu()
    }

}

extension WUViewController {
    
    func makeuu() {
        view.addSubview(tpView)
        tpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tpView.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    
}
