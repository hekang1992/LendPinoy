//
//  LPTwoCell.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/4.
//

import UIKit
import RxSwift
import RxCocoa

class LPTwoCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 18.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return titleLabel
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .clear
        bgView.layer.cornerRadius = 10.lpix()
        bgView.layer.borderWidth = 5.lpix()
        bgView.layer.borderColor = UIColor.init(hex: "#2CD7BB").cgColor
        return bgView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 12.lpix())!, textColor: UIColor.init(hex: "#D2D3D7"), textAlignment: .left)
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
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(22.5.lpix())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(titleLabel.snp.bottom).offset(15.lpix())
            make.height.equalTo(196.lpix())
            make.bottom.equalToSuperview().offset(-30.lpix())
        }
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalToSuperview().offset(15.lpix())
            make.size.equalTo(CGSize(width: 285.lpix(), height: 120.lpix()))
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.lpix())
            make.right.equalToSuperview().offset(-30.lpix())
            make.top.equalTo(icon.snp.bottom).offset(15.lpix())
        }
        
        model.subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.titleLabel.text = model.title ?? ""
            self.icon.image = UIImage(named: model.icon ?? "")
            self.descLabel.text = model.desc ?? ""
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<ActionModel?>(value: nil)
    
}
