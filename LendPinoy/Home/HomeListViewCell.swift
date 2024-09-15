//
//  HomeListViewCell.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/16.
//

import UIKit
import RxSwift
import RxCocoa

class HomeListViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<deliveryModel?>(value: nil)

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.init(hex: "#F2F2F2")
        icon.layer.cornerRadius = 4.lpix()
        icon.layer.masksToBounds = true
        return icon
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 20.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var mLabel: UILabel = {
        let mLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 26.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return mLabel
    }()
    
    lazy var sLabel: UILabel = {
        let sLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 14.lpix())!, textColor: UIColor.init(hex: "#CFD9D8"), textAlignment: .left)
        return sLabel
    }()
    
    lazy var label: UILabel = {
        let label = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 17.lpix())!, textColor: UIColor.init(hex: "#FFFFFF"), textAlignment: .center)
        label.layer.cornerRadius = 4.lpix()
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
            make.top.equalToSuperview().offset(15.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.height.equalTo(22.lpix())
            make.bottom.equalToSuperview().offset(-74.lpix())
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40.lpix(), height: 40.lpix()))
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(nameLabel.snp.bottom).offset(14.lpix())
        }
        
        mLabel.snp.makeConstraints { make in
            make.height.equalTo(30.lpix())
            make.left.equalTo(icon.snp.right).offset(15.lpix())
            make.top.equalTo(nameLabel.snp.bottom).offset(7.lpix())
        }
        
        sLabel.snp.makeConstraints { make in
            make.height.equalTo(15.lpix())
            make.left.equalTo(icon.snp.right).offset(15.lpix())
            make.top.equalTo(mLabel.snp.bottom).offset(1.lpix())
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(14.lpix())
            make.size.equalTo(CGSize(width: 85.lpix(), height: 40.lpix()))
            make.right.equalToSuperview().offset(-15.lpix())
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(2.lpix())
            make.left.equalToSuperview().offset(15.lpix())
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
        
    }
    
}
