//
//  LPLoginViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/2.
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
        let location = LPDingWeiManager()
        location.startUpdatingLocation { locationModel in
            
        }
    }

}

extension LPLoginViewController {
    
    
    func tapClick() {
        
        loginView.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        loginView.codeBlock = { [weak self] in
            self?.sendcode()
        }
        
    }
    
    func sendcode() {
        let requestManager = LPRequestManager()
        let dict = ["app": "swift", 
                    "vaguely": self.loginView.phoneTx.text ?? "",
                    "quizzical": "flash"]
        requestManager.uploadDataAPI(params: dict, 
                                     pageUrl: "/lpinoy/slipped/hitch/narrow",
                                     method: .post) { [weak self] result in
            switch result {
            case .success(let baseModel):
                ToastUtility.showToast(message: baseModel.frown ?? "")
                self?.pushCodeVc()
                break
            case .failure(_):
                break
            }
        }
    }
    
    func pushCodeVc() {
        let codeVc = LPCodeViewController()
        codeVc.phone.accept(self.loginView.phoneTx.text ?? "")
        self.navigationController?.pushViewController(codeVc, animated: true)
    }
    
}
