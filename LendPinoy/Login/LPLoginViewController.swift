//
//  LPLoginViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/2.
//

import UIKit

class LPLoginViewController: LPBaseViewController {
    
    lazy var loginView: LPLoginView = {
        let loginView = LPLoginView()
        loginView.backgroundColor = .white
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tapClick()
    }

}

extension LPLoginViewController {
    
    
    func tapClick() {
        
        loginView.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        loginView.codeBlock = { [weak self] in
            let codeVc = LPCodeViewController()
            codeVc.phone.accept(self?.loginView.phoneTx.text ?? "")
            self?.navigationController?.pushViewController(codeVc, animated: true)
        }
        
    }
    
}
