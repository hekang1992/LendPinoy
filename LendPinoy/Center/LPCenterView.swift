//
//  LPCenterView.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/1.
//

import UIKit
import RxSwift

class LPCenterView: LPJCView {
    
    var block: (() -> Void)?
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    var block3: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return scrollView
    }()
    
    lazy var touxiang: UIImageView = {
        let touxiang = UIImageView()
        touxiang.image = UIImage(named: "centericon")
        return touxiang
    }()
    
    lazy var phoneLabe: UILabel = {
        let phoneLabe = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 26)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        phoneLabe.text = UserDefaults.standard.object(forKey: LP_LOGIN) as? String ?? ""
        return phoneLabe
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "agreeimage"), for: .normal)
        twoBtn.adjustsImageWhenHighlighted = false
        return twoBtn
    }()
    
    lazy var twoBtn1: UIButton = {
        let twoBtn1 = UIButton(type: .custom)
        twoBtn1.setImage(UIImage(named: "lianxiwomne"), for: .normal)
        twoBtn1.adjustsImageWhenHighlighted = false
        return twoBtn1
    }()
    
    lazy var twoBtn2: UIButton = {
        let twoBtn2 = UIButton(type: .custom)
        twoBtn2.setImage(UIImage(named: "guanyuwomena"), for: .normal)
        twoBtn2.adjustsImageWhenHighlighted = false
        return twoBtn2
    }()
    
    lazy var twoBtn3: UIButton = {
        let twoBtn3 = UIButton(type: .custom)
        twoBtn3.setImage(UIImage(named: "zhanghaoguanli"), for: .normal)
        twoBtn3.adjustsImageWhenHighlighted = false
        return twoBtn3
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(touxiang)
        scrollView.addSubview(phoneLabe)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(twoBtn1)
        scrollView.addSubview(twoBtn2)
        scrollView.addSubview(twoBtn3)
        makeupss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPCenterView {
    
    func makeupss() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        touxiang.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 70, height: 70))
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 30)
            make.centerX.equalToSuperview()
        }
        
        phoneLabe.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(touxiang.snp.bottom).offset(15)
            make.height.equalTo(32.5)
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(103)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(phoneLabe.snp.bottom).offset(35)
        }
        
        twoBtn1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(twoBtn.snp.bottom).offset(20)
        }
        
        twoBtn2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(twoBtn1.snp.bottom).offset(20)
        }
        
        twoBtn3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(twoBtn2.snp.bottom).offset(20)
        }
        
        scrollView
            .rx
            .contentOffset
            .subscribe(onNext: { [weak self] contfset in
                guard let self = self else { return }
                if contfset.y < 0 {
                    self.scrollView.setContentOffset(.zero, animated: false)
                }
            }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?()
        }).disposed(by: disposeBag)
        
        twoBtn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block1?()
        }).disposed(by: disposeBag)
        twoBtn2.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        twoBtn3.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block3?()
        }).disposed(by: disposeBag)
    }
    
}

