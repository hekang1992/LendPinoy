//
//  LPNavgationView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/1.
//

import UIKit
import RxSwift

class LPNavgationView: LPJCView {
    
    var block: (() -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "leftjiantoupn"), for: .normal)
        return backBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 18)!, textColor: UIColor.init(hex: "#393939"), textAlignment: .center)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(titleLabel)
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
        }
        tap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPNavgationView {
    
    func tap() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?()
        }).disposed(by: disposeBag)
    }
    
}


class LPNavgationTwoView: LPJCView {
    
    var block: (() -> Void)?
    
    var mBlock: ((UIButton) -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "leftjiantoupn"), for: .normal)
        return backBtn
    }()
    
    lazy var eBtn: UIButton = {
        let eBtn = UIButton(type: .custom)
        eBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18)
        eBtn.setTitle("E-wallet", for: .normal)
        eBtn.isSelected = true
        eBtn.contentHorizontalAlignment = .left
        eBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
        eBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .selected)
        return eBtn
    }()
    
    lazy var mBtn: UIButton = {
        let mBtn = UIButton(type: .custom)
        mBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18)
        mBtn.setTitle("Bank Card", for: .normal)
        mBtn.isSelected = false
        mBtn.contentHorizontalAlignment = .left
        mBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
        mBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .selected)
        return mBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(eBtn)
        addSubview(mBtn)
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        eBtn.snp.makeConstraints { make in
            make.left.equalTo(backBtn.snp.right).offset(54)
            make.centerY.equalTo(backBtn.snp.centerY)
            make.size.equalTo(CGSize(width: 65, height: 20))
        }
        mBtn.snp.makeConstraints { make in
            make.left.equalTo(eBtn.snp.right).offset(52)
            make.centerY.equalTo(backBtn.snp.centerY)
            make.size.equalTo(CGSize(width: 80, height: 20))
        }
        tap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPNavgationTwoView {
    
    func tap() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?()
        }).disposed(by: disposeBag)
        
        
        eBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.selectButton(self.eBtn, deselect: self.mBtn)
            self.mBlock?(self.eBtn)
        }).disposed(by: disposeBag)
        
        mBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.selectButton(self.mBtn, deselect: self.eBtn)
            self.mBlock?(self.mBtn)
        }).disposed(by: disposeBag)
        
    }
    
    private func selectButton(_ selectedButton: UIButton, deselect otherButton: UIButton) {
        selectedButton.isSelected = true
        otherButton.isSelected = false
    }
    
}
