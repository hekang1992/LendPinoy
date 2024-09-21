//
//  LPCommonView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/5.
//

import UIKit
import RxSwift
import RxGesture

class LPCommonView: LPJCView {
    
    enum TypeEnum {
        case normal
        case click
    }
    
    var timeBlock: ((UIButton) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 20)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "righticona")
        return icon
    }()
    
    lazy var nameTx: NoCopyTextFiled = {
        let nameTx = NoCopyTextFiled()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrString = NSMutableAttributedString(string: "Enter your information", attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.init(hex: "#CFD9D8") as Any,
            .font: UIFont(name: bold_MarketFresh, size: 20)!
        ])
        nameTx.attributedPlaceholder = attrString
        nameTx.textAlignment = .left
        nameTx.tintColor = UIColor.init(hex: "#2CD7BB")
        nameTx.font = UIFont(name: bold_MarketFresh, size: 20)
        nameTx.textColor = UIColor.init(hex: "#303434")
        return nameTx
    }()
    
    lazy var timeBtn: UIButton = {
        let timeBtn = UIButton(type: .custom)
        timeBtn.contentHorizontalAlignment = .left
        timeBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20)
        timeBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .normal)
        return timeBtn
    }()
    
    init(frame: CGRect, typeEnum: TypeEnum) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(bgView)
        bgView.addSubview(icon)
        if typeEnum == .click {
            bgView.addSubview(timeBtn)
            timeBtn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview()
                make.right.equalTo(icon.snp.left).offset(-5)
            }
            timeBtn.rx.tap.subscribe(onNext: { [weak self] in
                if let self = self {
                    self.timeBlock?(self.timeBtn)
                }
            }).disposed(by: disposeBag)
        } else {
            bgView.addSubview(nameTx)
            nameTx.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.top.bottom.equalToSuperview()
                make.right.equalTo(icon.snp.left).offset(-5)
            }
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.height.equalTo(24)
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
