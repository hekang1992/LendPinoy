//
//  LPCodeView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/2.
//

import UIKit
import RxSwift
import RxCocoa

class LPCodeView: LPJCView {
    
    var codeBlock: (() -> Void)?
    
    var loginBlock: (() -> Void)?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        navView.titleLabel.text = "Please enter the code"
        return navView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var noLabel: UILabel = {
        let noLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 16)!, textColor: UIColor.init(hex: "#CFD9D8"), textAlignment: .left)
        noLabel.text = "“The verification code has been dispatched. Please check your messages.”"
        noLabel.numberOfLines = 0
        return noLabel
    }()
    
    lazy var phoneTx: NoCopyTextFiled = {
        let phoneTx = NoCopyTextFiled()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSMutableAttributedString(string: "Verification Code", attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.init(hex: "#CFD9D8") as Any,
            .font: UIFont(name: bold_MarketFresh, size: 22)!
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.textAlignment = .center
        phoneTx.tintColor = UIColor.init(hex: "#2CD7BB")
        phoneTx.font = UIFont(name: bold_MarketFresh, size: 22)
        phoneTx.textColor = UIColor.init(hex: "#303434")
        phoneTx.keyboardType = .numberPad
        return phoneTx
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.isHidden = true
        canBtn.setImage(UIImage(named: "canceliccc"), for: .normal)
        return canBtn
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Send", for: .normal)
        codeBtn.setTitleColor(UIColor.white, for: .normal)
        codeBtn.backgroundColor = UIColor(hex: "#2CD7BB")
        codeBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20)
        codeBtn.isEnabled = false
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#2CD7BB")
        loginBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20)
        return loginBtn
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = UIColor.init(hex: "#F3FBFA")
        bgView1.layer.cornerRadius = 4
        return bgView1
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "dunpaiopp")
        return icon
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 12)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        descLabel.text = "We will provide comprehensive protection for your privacy data."
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navView)
        addSubview(noLabel)
        addSubview(bgView)
        bgView.addSubview(phoneTx)
        bgView.addSubview(canBtn)
        addSubview(bgView1)
        bgView1.addSubview(icon)
        bgView1.addSubview(descLabel)
        addSubview(codeBtn)
        addSubview(loginBtn)
        makeui()
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("-------------")
    }
    
}

extension LPCodeView {
    
    func makeui() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        noLabel.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(75)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(60)
            make.top.equalTo(noLabel.snp.bottom).offset(15)
        }
        phoneTx.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        canBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(54)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(35)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 14, height: 18))
        }
        descLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.left.equalTo(icon.snp.right).offset(10)
        }
        codeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(bgView1.snp.bottom).offset(10)
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(codeBtn.snp.bottom).offset(20)
        }
    }
    
    func tapClick() {
        phoneTx.rx.text
            .orEmpty
            .map { text in
                return String(text.prefix(6))
            }
            .bind(to: phoneTx.rx.text)
            .disposed(by: disposeBag)
        
        phoneTx.rx.text
            .orEmpty
            .map { text in
                return text.count >= 6
            }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isExceeded in
                if isExceeded {
                    self?.loginBlock?()
                    self?.phoneTx.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        phoneTx.rx.controlEvent(.editingChanged)
            .withLatestFrom(phoneTx.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.count > 6 {
                    self.phoneTx.text = String(text.prefix(6))
                }
            })
            .disposed(by: disposeBag)
        
        phoneTx.rx.text
            .orEmpty
            .map { $0.isEmpty }
            .bind(to: canBtn.rx.isHidden)
            .disposed(by: disposeBag)
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.phoneTx.text = ""
            self?.canBtn.isHidden = true
        }).disposed(by: disposeBag)
        
        codeBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.codeBlock?()
        }).disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.loginBlock?()
        }).disposed(by: disposeBag)
        
    }
}
