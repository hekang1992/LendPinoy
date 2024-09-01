//
//  LPLoginView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/2.
//

import UIKit
import RxSwift
import RxCocoa

class LPLoginView: UIView {
    
    let disposeBag = DisposeBag()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navView)
        addSubview(bgView)
        bgView.addSubview(noLabel)
        bgView.addSubview(lineView)
        bgView.addSubview(phoneTx)
        bgView.addSubview(canBtn)
        makeui()
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPLoginView {
    
    func makeui() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusHeightManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(60.lpix())
            make.top.equalTo(navView.snp.bottom).offset(104.lpix())
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
    }
    
    func tapClick() {
        phoneTx.rx.text
            .orEmpty
            .map { text in
                return String(text.prefix(11))
            }
            .bind(to: phoneTx.rx.text)
            .disposed(by: disposeBag)
        
        phoneTx.rx.text
            .orEmpty
            .map { text in
                return text.count >= 11
            }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] isExceeded in
                if isExceeded {
                    self?.phoneTx.resignFirstResponder()
                }
            })
            .disposed(by: disposeBag)
        
        phoneTx.rx.controlEvent(.editingChanged)
            .withLatestFrom(phoneTx.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if text.count > 11 {
                    self.phoneTx.text = String(text.prefix(11))
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

