//
//  LPAccountManViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/1.
//

import UIKit
import TYAlertController
import RxSwift

class LPAccountManViewController: LPBaseViewController {
    
    lazy var outView: LogView = {
        let outView = LogView(frame: self.view.bounds)
        return outView
    }()
    
    lazy var delView: DelView = {
        let delView = DelView(frame: self.view.bounds)
        return delView
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.adjustsImageWhenHighlighted = false
        btn1.setImage(UIImage(named: "tuichulogin"), for: .normal)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.adjustsImageWhenHighlighted = false
        btn2.setImage(UIImage(named: "shangchuzha"), for: .normal)
        return btn2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNavView(title: "Manage account")
        view.addSubview(btn1)
        view.addSubview(btn2)
        makesnpView()
        tap()
    }
    
}

extension LPAccountManViewController {
    
    func makesnpView() {
        btn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(navView.snp.bottom).offset(20.lpix())
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
        }
        btn2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(btn1.snp.bottom).offset(20.lpix())
            make.centerX.equalToSuperview()
            make.height.equalTo(110.lpix())
        }
    }
    
    func tap() {
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        btn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let alertVc = TYAlertController(alert: self.outView, preferredStyle: .alert)
            self.outView.titleLabel.text = "Are you sure you want to log out?"
            self.present(alertVc!, animated: true)
            self.outView.block1 = { [weak self] in
                self?.poplogOut()
            }
            self.outView.block2 = { [weak self] in
                self?.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
        
        btn2.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let alertVc = TYAlertController(alert: self.delView, preferredStyle: .alert)
            self.present(alertVc!, animated: true)
            self.delView.block1 = { [weak self] in
                self?.zxAc()
            }
            self.delView.block2 = { [weak self] in
                self?.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    func poplogOut() {
        let man = LPRequestManager()
        man.requestAPI(params: ["glaring": "shine", "out": "1", "strolling": "auth"], pageUrl: "/lpinoy/hurried/middle/hideji", method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    LPLoginInfo.removeDengLuInfo()
                    self?.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
                    })
                }
                break
            case .failure(let failure):
                break
            }
        }
    }
    
    func zxAc() {
        let man = LPRequestManager()
        man.requestAPI(params: ["listen": "music", "zx": "true", "go": "oc", "from": "home"], pageUrl: "/lpinoy/street/right/picked", method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    LPLoginInfo.removeDengLuInfo()
                    self?.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
                    })
                }
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}

class LogView: UIView {
    
    let disposeBag = DisposeBag()
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 4.lpix()
        return bgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 36.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Are you sure you want to log out?"
        return titleLabel
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18.lpix())
        confirmBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
        confirmBtn.backgroundColor = UIColor.init(hex: "#F3FBFA")
        confirmBtn.layer.cornerRadius = 4.lpix()
        return confirmBtn
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setTitle("Cancel", for: .normal)
        canBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18.lpix())
        canBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        canBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        canBtn.layer.cornerRadius = 4.lpix()
        return canBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(confirmBtn)
        bgView.addSubview(canBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.lpix(), height: 277.lpix()))
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(21.5.lpix())
        }
        confirmBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.bottom.equalToSuperview().offset(-20.lpix())
            make.size.equalTo(CGSize(width: 140.lpix(), height: 60.lpix()))
        }
        canBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.lpix())
            make.bottom.equalToSuperview().offset(-20.lpix())
            make.size.equalTo(CGSize(width: 140.lpix(), height: 60.lpix()))
        }
        tap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tap() {
        confirmBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block1?()
        }).disposed(by: disposeBag)
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        
    }
    
}

class DelView: UIView {
    
    let disposeBag = DisposeBag()
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 4.lpix()
        return bgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 26.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Please note that deleting your account will permanently remove the following data and features. Proceed with caution."
        return titleLabel
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle("Confirm", for: .normal)
        confirmBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18.lpix())
        confirmBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
        confirmBtn.backgroundColor = UIColor.init(hex: "#F3FBFA")
        confirmBtn.layer.cornerRadius = 4.lpix()
        return confirmBtn
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setTitle("Cancel", for: .normal)
        canBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18.lpix())
        canBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        canBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        canBtn.layer.cornerRadius = 4.lpix()
        return canBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(confirmBtn)
        bgView.addSubview(canBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.lpix(), height: 306.5.lpix()))
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(21.5.lpix())
        }
        confirmBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.bottom.equalToSuperview().offset(-20.lpix())
            make.size.equalTo(CGSize(width: 140.lpix(), height: 60.lpix()))
        }
        canBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.lpix())
            make.bottom.equalToSuperview().offset(-20.lpix())
            make.size.equalTo(CGSize(width: 140.lpix(), height: 60.lpix()))
        }
        tap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tap() {
        confirmBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block1?()
        }).disposed(by: disposeBag)
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        
    }
    
}
