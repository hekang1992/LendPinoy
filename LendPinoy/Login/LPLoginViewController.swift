//
//  LPLoginViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/2.
//

import UIKit
import TYAlertController

class LPLoginViewController: LPBaseViewController {
    
    lazy var loginView: LPLoginView = {
        let loginView = LPLoginView()
        loginView.backgroundColor = .white
        return loginView
    }()
    
    lazy var phoView: LPTCPView = {
        let phoView = LPTCPView(frame: self.view.bounds)
        return phoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tapClick()
        let ti = SystemInfo.getCurrentTime()
        UserDefaults.standard.set(ti, forKey: LOGIN_START_LP)
        UserDefaults.standard.synchronize()
        let location = LPDingWeiManager()
        location.startUpdatingLocation { locationModel in
            
        }
    }
    
}

extension LPLoginViewController {
    
    func tcpView() {
        let alertVc = TYAlertController(alert: self.phoView, preferredStyle: .alert)
        self.phoView.phone.text = self.loginView.phoneTx.text ?? ""
        self.present(alertVc!, animated: true)
        self.phoView.block1 = { [weak self] in
            self?.dismiss(animated: true)
        }
        self.phoView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.sendcode()
            })
        }
    }
    
    func tapClick() {
        
        loginView.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        loginView.codeBlock = { [weak self] in
            self?.tcpView()
        }
        
        loginView.yinBlock = { [weak self] in
            guard let self = self else { return }
            let url  = H5_URL + "/thecamping"
            self.pushToWebVc(form: url)
        }
        
        loginView.llBlock = { [weak self] in
            guard let self = self else { return }
            let url  = H5_URL + "/mostprecious"
            self.pushToWebVc(form: url)
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
