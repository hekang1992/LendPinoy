//
//  HomeListViewCell.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/16.
//

import UIKit
import RxSwift
import RxCocoa

class HomeListViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<deliveryModel?>(value: nil)
    
    var model1 = BehaviorRelay<dazedModel?>(value: nil)

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.init(hex: "#F2F2F2")
        icon.layer.cornerRadius = 4
        icon.layer.masksToBounds = true
        return icon
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 20)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var mLabel: UILabel = {
        let mLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 26)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return mLabel
    }()
    
    lazy var sLabel: UILabel = {
        let sLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 14)!, textColor: UIColor.init(hex: "#CFD9D8"), textAlignment: .left)
        return sLabel
    }()
    
    lazy var label: UILabel = {
        let label = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 17)!, textColor: UIColor.init(hex: "#FFFFFF"), textAlignment: .center)
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.init(hex: "#2CD7BB")
        return label
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(hex: "#F0FAF9")
        return lineView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(icon)
        contentView.addSubview(mLabel)
        contentView.addSubview(sLabel)
        contentView.addSubview(label)
        contentView.addSubview(lineView)
        makess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomeListViewCell {
    
    func makess() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(22)
            make.bottom.equalToSuperview().offset(-74)
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(nameLabel.snp.bottom).offset(14)
        }
        
        mLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.left.equalTo(icon.snp.right).offset(15)
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
        }
        
        sLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.left.equalTo(icon.snp.right).offset(15)
            make.top.equalTo(mLabel.snp.bottom).offset(1)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14)
            make.size.equalTo(CGSize(width: 85, height: 40))
            make.right.equalToSuperview().offset(-15)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        model.subscribe(onNext: { [weak self] dmodel in
            guard let self = self, let dmodel = dmodel  else { return }
            self.icon.kf.setImage(with: URL(string: dmodel.endless ?? ""))
            self.nameLabel.text = dmodel.shrines ?? ""
            self.mLabel.text = dmodel.prayed ?? ""
            self.sLabel.text = dmodel.afraid ?? ""
            self.label.text = dmodel.husband ?? ""
        }).disposed(by: disposeBag)
        
        model1.subscribe(onNext: { [weak self] dmodel in
            guard let self = self, let dmodel = dmodel  else { return }
            self.icon.kf.setImage(with: URL(string: dmodel.endless ?? ""))
            self.nameLabel.text = dmodel.shrines ?? ""
//            self.mLabel.text = dmodel.prayed ?? ""
//            self.sLabel.text = dmodel.afraid ?? ""
//            self.label.text = dmodel.husband ?? ""
        }).disposed(by: disposeBag)
        
    }
    
}
