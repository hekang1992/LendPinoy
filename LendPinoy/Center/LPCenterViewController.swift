//
//  LPCenterViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/29.
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LPTabBarManager.showTabBar()
    }
    
}


extension LPCenterViewController {
    
    func tap() {
        centerView.block = { [weak self] in
            let agVc = LPAgreeViewController()
            self?.navigationController?.pushViewController(agVc, animated: true)
        }
        centerView.block1 = { [weak self] in
            guard let self = self else { return }
            let url  = H5_URL + "/thisbeautiful"
            self.pushToWebVc(form: url)
        }
        centerView.block2 = { [weak self] in
            guard let self = self else { return }
            let url  = H5_URL
            self.pushToWebVc(form: url)
        }
        centerView.block3 = { [weak self] in
            let acc = LPAccountManViewController()
            self?.navigationController?.pushViewController(acc, animated: true)
        }
    }
    
}

