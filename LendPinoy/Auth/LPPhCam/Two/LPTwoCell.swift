//
//  LPTwoCell.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/4.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class LPTwoCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 18)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return titleLabel
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 5
        bgView.layer.borderColor = UIColor.init(hex: "#2CD7BB").cgColor
        return bgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 12)!, textColor: UIColor.init(hex: "#D2D3D7"), textAlignment: .left)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Verification")
        return icon
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(descLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(22.5)
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.height.equalTo(196)
            make.bottom.equalToSuperview().offset(-30)
        }
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 285, height: 120))
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(icon.snp.bottom).offset(15)
        }
        
        model.subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.titleLabel.text = model.title ?? ""
            if let icon = model.icon {
                if icon == "Verification" || icon == "Recognition" {
                    self.icon.image = UIImage(named: icon)
                }else {
                    self.icon.kf.setImage(with: URL(string: icon))
                }
            }
            
            self.descLabel.text = model.desc ?? ""
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<ActionModel?>(value: nil)
    
}
