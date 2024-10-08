//
//  LPAgreeViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/1.
//

import UIKit

class LPAgreeViewController: LPBaseViewController {
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.adjustsImageWhenHighlighted = false
        btn1.setImage(UIImage(named: "daikuanpin"), for: .normal)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.adjustsImageWhenHighlighted = false
        btn2.setImage(UIImage(named: "yinsidianji"), for: .normal)
        return btn2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addNavView(title: "Agreement")
        view.addSubview(btn1)
        view.addSubview(btn2)
        makesnpView()
        tap()
    }
}

extension LPAgreeViewController {
    
    func makesnpView() {
        btn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(navView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        btn2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(btn1.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    func tap() {
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        btn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let url  = H5_URL + "/mostprecious"
            self.pushToWebVc(form: url)
        }).disposed(by: disposeBag)
        
        btn2.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let url  = H5_URL + "/thecamping"
            self.pushToWebVc(form: url)
        }).disposed(by: disposeBag)
    }
    
}
