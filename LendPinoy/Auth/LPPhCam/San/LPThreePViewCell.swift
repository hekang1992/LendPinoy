//
//  LPThreePViewCell.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/7.
//

import UIKit
import RxSwift
import RxRelay

class LPThreePViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var tapBlock: ((UIButton) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 20.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.lpix()
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "righticona")
        return icon
    }()
    
    lazy var icon1: UIImageView = {
        let icon1 = UIImageView()
        icon1.image = UIImage(named: "righticona")
        return icon1
    }()
    
    lazy var label1: UILabel = {
        let label1 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 22.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        label1.text = "Camaraderie"
        return label1
    }()
    
    lazy var label2: UILabel = {
        let label2 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 22.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        label2.text = "Name"
        return label2
    }()
    
    lazy var label3: UILabel = {
        let label3 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 16.lpix())!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        label3.text = "Phone"
        return label3
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(icon1)
        bgView.addSubview(label1)
        bgView.addSubview(label2)
        bgView.addSubview(label3)
        makess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<dazedModel?>(value: nil)
    
}

extension LPThreePViewCell {
    
    func makess() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalToSuperview().offset(20.lpix())
            make.height.equalTo(24.lpix())
            make.bottom.equalToSuperview().offset(-150.lpix())
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.centerX.equalToSuperview()
            make.height.equalTo(135.lpix())
        }
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.lpix())
            make.right.equalToSuperview().offset(-25.lpix())
            make.size.equalTo(CGSize(width: 17.lpix(), height: 17.lpix()))
        }
        icon1.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(28.lpix())
            make.right.equalToSuperview().offset(-25.lpix())
            make.size.equalTo(CGSize(width: 17.lpix(), height: 17.lpix()))
        }
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.lpix())
            make.left.equalToSuperview().offset(30.lpix())
            make.height.equalTo(25.lpix())
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(14.lpix())
            make.left.equalToSuperview().offset(30.lpix())
            make.height.equalTo(26.lpix())
        }
        label3.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(10.lpix())
            make.left.equalToSuperview().offset(30.lpix())
            make.height.equalTo(18.lpix())
        }
        model.subscribe(onNext: { [weak self] model1 in
            guard let self = self, let model1 = model1 else { return }
            if let relationText = model1.relationText, !relationText.isEmpty {
                self.label1.text = relationText
            }
            if let quench = model1.quench, !quench.isEmpty {
                self.label2.text = quench
            }
            if let restaurants = model1.restaurants, !restaurants.isEmpty {
                self.label3.text = restaurants
            }
            self.nameLabel.text = model1.panicked ?? ""
        }).disposed(by: disposeBag)
    }
    
}
