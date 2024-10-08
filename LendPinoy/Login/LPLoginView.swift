//
//  LPLoginView.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/2.
//

import UIKit
import ActiveLabel
import RxSwift

class LPLoginView: LPJCView {
    
    var codeBlock: (() -> Void)?
    
    var yinBlock: (() -> Void)?
    
    var llBlock: (() -> Void)?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        return navView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "centericon")
        return icon
    }()
    
    lazy var noLabel: UILabel = {
        let noLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 22)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        noLabel.text = "63"
        return noLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#303434")
        return lineView
    }()
    
    lazy var phoneTx: NoCopyTextFiled = {
        let phoneTx = NoCopyTextFiled()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSMutableAttributedString(string: "Phone Number", attributes: [
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
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.isSelected = true
        sureBtn.setImage(UIImage(named: "surebtncc"), for: .selected)
        sureBtn.setImage(UIImage(named: "normalPoncad"), for: .normal)
        return sureBtn
    }()
    
    lazy var clickLabel: ActiveLabel = {
        let clickLabel = ActiveLabel()
        clickLabel.textColor = UIColor.init(hex: "#CFD9D8")
        clickLabel.font = UIFont(name: bold_MarketFresh, size: 16)
        clickLabel.text = "Before logging in, please make sure to read and agree to our Privacy Policy and Loan Terms to protect your rights and information security."
        clickLabel.numberOfLines = 0
        let customType1 = ActiveType.custom(pattern: "\\bPrivacy Policy\\b")
        let customType2 = ActiveType.custom(pattern: "\\bLoan Terms\\b")
        clickLabel.enabledTypes.append(customType2)
        clickLabel.enabledTypes.append(customType1)
        clickLabel.customColor[customType1] = UIColor.init(hex: "#2CD7BB")
        clickLabel.customColor[customType2] = UIColor.init(hex: "#2CD7BB")
        clickLabel.customSelectedColor[customType1] = UIColor.init(hex: "#2CD7BB")
        clickLabel.customSelectedColor[customType2] = UIColor.init(hex: "#2CD7BB")
        clickLabel.handleCustomTap(for: customType2) { [weak self] element in
            self?.llBlock?()
        }
        clickLabel.handleCustomTap(for: customType1) { [weak self] element in
            self?.yinBlock?()
        }
        let attributedString = NSMutableAttributedString(string: clickLabel.text!)
        let redUnderlineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#2CD7BB"),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.init(hex: "#2CD7BB"),
        ]
        let privacyPolicyRange = (clickLabel.text! as NSString).range(of: "Privacy Policy")
        let loanAgreementRange = (clickLabel.text! as NSString).range(of: "Loan Terms")
        attributedString.addAttributes(redUnderlineAttributes, range: loanAgreementRange)
        attributedString.addAttributes(redUnderlineAttributes, range: privacyPolicyRange)
        clickLabel.attributedText = attributedString
        return clickLabel
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Send OTP", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#2CD7BB")
        loginBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20)
        loginBtn.isEnabled = true
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navView)
        addSubview(icon)
        addSubview(bgView)
        bgView.addSubview(noLabel)
        bgView.addSubview(lineView)
        bgView.addSubview(phoneTx)
        bgView.addSubview(canBtn)
        addSubview(sureBtn)
        addSubview(clickLabel)
        addSubview(loginBtn)
        makeui()
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("=========")
    }
}

extension LPLoginView {
    
    func makeui() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navView.snp.bottom).offset(40)
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(60)
            make.top.equalTo(icon.snp.bottom).offset(30)
        }
        noLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19.5)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(25)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 3, height: 15))
            make.left.equalToSuperview().offset(63.5)
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(-25)
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        canBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(53)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        clickLabel.snp.makeConstraints { make in
            make.left.equalTo(sureBtn.snp.right).offset(10)
            make.top.equalTo(sureBtn.snp.top)
            make.right.equalToSuperview().offset(-20)
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(clickLabel.snp.bottom).offset(20)
        }
    }
    
    func tapClick() {
        phoneTx.rx.text
            .orEmpty
            .map { text in
                let limitedText = String(text.prefix(10))
                return (limitedText, limitedText.count >= 10)
            }
            .distinctUntilChanged { $0.0 == $1.0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] (text, isExceeded) in
                guard let self = self else { return }
                self.phoneTx.text = text
                if isExceeded {
                    self.phoneTx.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        phoneTx.rx.controlEvent(.editingChanged)
            .withLatestFrom(phoneTx.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.count > 10 {
                    self.phoneTx.text = String(text.prefix(10))
                }
            })
            .disposed(by: disposeBag)
        
        phoneTx.rx.text
            .orEmpty
            .map { $0.isEmpty }
            .bind(to: canBtn.rx.isHidden)
            .disposed(by: disposeBag)
        
        canBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.phoneTx.text = ""
                self?.canBtn.isHidden = true
            })
            .disposed(by: disposeBag)
        
        sureBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.sureBtn.isSelected.toggle()
            })
            .disposed(by: disposeBag)
        
        loginBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if !self.sureBtn.isSelected {
                    ToastUtility.showToast(message: "Please review and accept the App Agreement before logging in or registering")
                } else {
                    if self.phoneTx.text?.count ?? 0 > 0 {
                        self.codeBlock?()
                    } else {
                        ToastUtility.showToast(message: "Please enter a valid phone number")
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}

class NoCopyTextFiled: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(cut(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func paste(_ sender: Any?) {
        
    }
    
    override func copy(_ sender: Any?) {
        
    }
    
    override func cut(_ sender: Any?) {
        
    }
}

