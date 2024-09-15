//
//  LPCenterViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit

class LPCenterViewController: LPBaseViewController {
    
    lazy var centerView: LPCenterView = {
        let centerView = LPCenterView()
        return centerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tap()
        
    }

}


extension LPCenterViewController {
    
    func tap() {
        centerView.block = { [weak self] in
            let oli = LPOrderListViewController()
            oli.li.accept("4")
            self?.navigationController?.pushViewController(oli, animated: true)
        }
        centerView.block1 = { [weak self] in
            let acc = LPAccountManViewController()
            self?.navigationController?.pushViewController(acc, animated: true)
        }
        centerView.block2 = { [weak self] in
            let agVc = LPAgreeViewController()
            self?.navigationController?.pushViewController(agVc, animated: true)
        }
        centerView.block3 = { [weak self] in
            ToastUtility.showToast(message: "2")
        }
        centerView.block4 = { [weak self] in
            ToastUtility.showToast(message: "1")
        }
    }

}

