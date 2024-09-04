//
//  LPCodeViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/2.
//

import UIKit
import RxRelay

class LPCodeViewController: LPBaseViewController {
    
    var phone = BehaviorRelay<String>(value: "")
    
    var codeTime = 60
    
    var codeTimer: Timer!
    
    lazy var codeView: LPCodeView = {
        let codeView = LPCodeView()
        return codeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tapClick()
        startCode()
    }
    
}


extension LPCodeViewController {
    
    func startCode() {
        self.codeView.codeBtn.isEnabled = false
        codeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if codeTime > 0 {
            codeTime -= 1
            self.codeView.codeBtn.setTitle("Resend (\(self.codeTime)s)", for: .normal)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        codeTimer.invalidate()
        self.codeView.codeBtn.isEnabled = true
        self.codeView.codeBtn.setTitle("Resend", for: .normal)
        codeTime = 60
    }
    
    func tapClick() {
        codeView.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        codeView.codeBlock = { [weak self] in
            self?.sendcode()
        }
        codeView.loginBlock = { [weak self] in
            self?.loginInfo()
        }
    }
    
    func sendcode() {
        let requestManager = LPRequestManager()
        let dict = ["app": "swift", "vaguely": phone.value, "quizzical": "flash"]
        requestManager.uploadDataAPI(params: dict, pageUrl: "/lpinoy/slipped/hitch/narrow", method: .post) { [weak self] result in
            switch result {
            case .success(let baseModel):
                self?.startCode()
                ToastUtility.showToast(message: baseModel.frown ?? "")
                break
            case .failure(_):
                break
            }
        }
    }
    
    func loginInfo() {
        let requestManager = LPRequestManager()
        let dict = ["patchy": "autoASix", "page": self.codeView.phoneTx.text ?? "", "ordered": phone.value, "middle": "true"]
        requestManager.uploadDataAPI(params: dict, pageUrl: "/lpinoy/while/pages/nabeyaki-udon", method: .post) { [weak self] result in
            switch result {
            case .success(let baseModel):
                DispatchQueue.main.async {
                    self?.getloginMess(baseModel)
                    ToastUtility.showToast(message: baseModel.frown ?? "")
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func getloginMess(_ model: BaseModel) {
        let itselfModel = model.itself
        LPLoginInfo.saveDengLuInfo(itselfModel.ordered ?? "", itselfModel.moist ?? "")
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
    }
    
}
