//
//  LPTextViewCell.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/6.
//

import UIKit
import RxSwift
import RxRelay

class LPTextViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()

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
    
//    lazy var icon: UIImageView = {
//        let icon = UIImageView()
//        icon.image = UIImage(named: "righticona")
//        return icon
//    }()
    
    lazy var nameTx: NoCopyTextFiled = {
        let nameTx = NoCopyTextFiled()
        nameTx.textAlignment = .left
        nameTx.font = UIFont(name: bold_MarketFresh, size: 22)
        nameTx.textColor = UIColor.init(hex: "#2CD7BB")
        return nameTx
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
//        bgView.addSubview(icon)
        bgView.addSubview(nameTx)
        makess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<crossingModel?>(value: nil)
    
}

extension LPTextViewCell {
    
    func makess() {
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-95)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        nameTx.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(80)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
//        icon.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-25)
//            make.size.equalTo(CGSize(width: 17, height: 17))
//        }
        
        nameTx.rx.text.orEmpty.bind(onNext: { [weak self] text in
            guard let self = self else { return }
            if let model = self.model.value {
                model.completely = text
            }else {
                model.value?.completely = text
            }
        }).disposed(by: disposeBag)
        
        model.subscribe(onNext: { [weak self] model1 in
            guard let self = self, let model1 = model1 else { return }
            self.nameLabel.text = model1.readily ?? ""
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            let attrString = NSMutableAttributedString(string: model1.met ?? "", attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.init(hex: "#CFD9D8") as Any,
                .font: UIFont(name: bold_MarketFresh, size: 22)!
            ])
            self.nameTx.attributedPlaceholder = attrString
            if model1.glued == "1" {
                self.nameTx.keyboardType = .numberPad
            } else {
                self.nameTx.keyboardType = .default
            }
            if let completely = model1.completely, !completely.isEmpty {
                self.nameTx.text = completely
            }else {
                self.nameTx.text = ""
                
            }
        }).disposed(by: disposeBag)
        
    }
    
    
}
