//
//  PoPAuthView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/4.
//

import UIKit
import RxSwift

class PoPAuthView: LPJCView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var youLabel: UILabel = {
        let youLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 32)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        youLabel.text = "Verification using"
        return youLabel
    }()
    
    lazy var xuanLabel: UILabel = {
        let xuanLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 32)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        return xuanLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 26)!, textColor: UIColor.init(hex: "#D2D3D7"), textAlignment: .left)
        descLabel.numberOfLines = 0
        descLabel.text = "Please confirm the selected document type to avoid any errors."
        return descLabel
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "changerepadinn")
        return imageView
    }()
    
    lazy var changeBtn: UIButton = {
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("Change", for: .normal)
        changeBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22)
        changeBtn.setTitleColor(UIColor.init(hex: "#2CD7BB"), for: .normal)
        return changeBtn
    }()
    
    lazy var queBtn: UIButton = {
        let queBtn = UIButton(type: .custom)
        queBtn.setTitle("Confirm", for: .normal)
        queBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22)
        queBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        return queBtn
    }()
    
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(youLabel)
        bgView.addSubview(xuanLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(imageView)
        imageView.addSubview(changeBtn)
        imageView.addSubview(queBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335, height: 340))
        }
        youLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(20)
        }
        xuanLabel.snp.makeConstraints { make in
            make.top.equalTo(youLabel.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(xuanLabel.snp.bottom).offset(20)
        }
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        changeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.top.equalToSuperview()
            make.right.equalTo(self.snp.centerX)
        }
        queBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.top.equalToSuperview()
            make.left.equalTo(self.snp.centerX)
        }
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PoPAuthView {
    
    func tapClick() {
        
        changeBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        
        queBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
        
    }
    
    
}
