//
//  LPTCPView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/16.
//

import UIKit

typealias PBlock = () -> Void
class LPTCPView: LPJCView {
    
    var block1: PBlock?
    
    var block2: PBlock?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = .white
        return bgView
    }()

    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 36)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        descLabel.numberOfLines = 0
        descLabel.text = "The phone number you entered is:"
        return descLabel
    }()
    
    lazy var phone: UILabel = {
        let phone = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 30)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        return phone
    }()

    lazy var comBtn: UIButton = {
        let comBtn = UIButton(type: .custom)
        comBtn.layer.cornerRadius = 4
        comBtn.setTitle("Confirm", for: .normal)
        comBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        comBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22)
        return comBtn
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setImage(UIImage(named: "canceliccc"), for: .normal)
        return canBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(descLabel)
        bgView.addSubview(phone)
        bgView.addSubview(comBtn)
        bgView.addSubview(comBtn)
        bgView.addSubview(canBtn)
        
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 300))
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(21)
            make.right.equalToSuperview().offset(-25)
        }
        phone.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(30)
            make.height.equalTo(31)
        }
        canBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        comBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phone.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(60)
        }
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        comBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
