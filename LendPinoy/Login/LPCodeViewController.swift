//
//  LPCodeViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/2.
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
        codeView.codeBlock = {
            
        }
        codeView.loginBlock = {
            NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
        }
        
    }
    
}
