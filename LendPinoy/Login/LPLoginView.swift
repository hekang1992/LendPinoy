//
//  LPLoginView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/2.
//

import UIKit
import RxSwift
import RxCocoa
import ActiveLabel

class LPLoginView: UIView {
    
    let disposeBag = DisposeBag()
    
    var codeBlock: (() -> Void)?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        return navView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.lpix()
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "AppIcon")
        return icon
    }()
    
    lazy var noLabel: UILabel = {
        let noLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 22.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
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
            .font: UIFont(name: bold_MarketFresh, size: 22.lpix())!
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.textAlignment = .center
        phoneTx.tintColor = UIColor.init(hex: "#2CD7BB")
        phoneTx.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
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
    
    lazy var yinsiLabel: ActiveLabel = {
        let yinsiLabel = ActiveLabel()
        yinsiLabel.font = UIFont(name: bold_MarketFresh, size: 16.lpix())
        yinsiLabel.textColor = UIColor.init(hex: "#CFD9D8")
        yinsiLabel.text = "By checking this box, you agree to the Privacy Policy and Loan Agreement."
        yinsiLabel.numberOfLines = 0
        let customType1 = ActiveType.custom(pattern: "\\bPrivacy Policy\\b")
        let customType2 = ActiveType.custom(pattern: "\\bLoan Agreement\\b")
        yinsiLabel.enabledTypes.append(customType1)
        yinsiLabel.enabledTypes.append(customType2)
        yinsiLabel.customColor[customType1] = UIColor.init(hex: "#2CD7BB")
        yinsiLabel.customColor[customType2] = UIColor.init(hex: "#2CD7BB")
        yinsiLabel.customSelectedColor[customType1] = UIColor.init(hex: "#2CD7BB")
        yinsiLabel.customSelectedColor[customType2] = UIColor.init(hex: "#2CD7BB")
        yinsiLabel.handleCustomTap(for: customType1) { element in
            ToastUtility.showToast(message: "Tapped on Privacy Policy")
        }
        yinsiLabel.handleCustomTap(for: customType2) { element in
            ToastUtility.showToast(message: "Tapped on Loan Agreement")
        }
        let attributedString = NSMutableAttributedString(string: yinsiLabel.text!)
        let redUnderlineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hex: "#2CD7BB"),
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: UIColor.init(hex: "#2CD7BB"),
        ]
        let privacyPolicyRange = (yinsiLabel.text! as NSString).range(of: "Privacy Policy")
        let loanAgreementRange = (yinsiLabel.text! as NSString).range(of: "Loan Agreement")
        attributedString.addAttributes(redUnderlineAttributes, range: privacyPolicyRange)
        attributedString.addAttributes(redUnderlineAttributes, range: loanAgreementRange)
        yinsiLabel.attributedText = attributedString
        return yinsiLabel
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Send Code", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor(hex: "#2CD7BB")
        loginBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20.lpix())
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
        addSubview(yinsiLabel)
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

extension LPLoginView {
    
    func makeui() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navView.snp.bottom).offset(40.lpix())
            make.size.equalTo(CGSize(width: 90.lpix(), height: 90.lpix()))
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(60.lpix())
            make.top.equalTo(icon.snp.bottom).offset(30.lpix())
        }
        noLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19.5.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(25.lpix())
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 3.lpix(), height: 15.lpix()))
            make.left.equalToSuperview().offset(63.5.lpix())
        }
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(-20.lpix())
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        canBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20.lpix())
            make.size.equalTo(CGSize(width: 17.lpix(), height: 17.lpix()))
        }
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(bgView.snp.bottom).offset(53.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.size.equalTo(CGSize(width: 17.lpix(), height: 17.lpix()))
        }
        yinsiLabel.snp.makeConstraints { make in
            make.left.equalTo(sureBtn.snp.right).offset(10.lpix())
            make.top.equalTo(sureBtn.snp.top)
            make.right.equalToSuperview().offset(-20.lpix())
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(60.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(yinsiLabel.snp.bottom).offset(20.lpix())
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

