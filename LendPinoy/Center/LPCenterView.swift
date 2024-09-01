//
//  LPCenterView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/1.
//

import UIKit
import RxSwift

class LPCenterView: UIView {
    
    let disposeBag = DisposeBag()
    
    var block: (() -> Void)?
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    var block3: (() -> Void)?
    var block4: (() -> Void)?

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
        touxiang.image = UIImage(named: "AppIcon")
        return touxiang
    }()
    
    lazy var phoneLabe: UILabel = {
        let phoneLabe = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 26.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        phoneLabe.text = "124324312"
        return phoneLabe
    }()
    
    lazy var huiyuan: UIImageView = {
        let huiyuan = UIImageView()
        huiyuan.image = UIImage(named: "Group_huiyuan")
        return huiyuan
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "Grouptwo"), for: .normal)
        twoBtn.adjustsImageWhenHighlighted = false
        return twoBtn
    }()
    
    lazy var twoBtn1: UIButton = {
        let twoBtn1 = UIButton(type: .custom)
        twoBtn1.setImage(UIImage(named: "acco"), for: .normal)
        twoBtn1.adjustsImageWhenHighlighted = false
        return twoBtn1
    }()
    
    lazy var twoBtn2: UIButton = {
        let twoBtn2 = UIButton(type: .custom)
        twoBtn2.setImage(UIImage(named: "xieyipn"), for: .normal)
        twoBtn2.adjustsImageWhenHighlighted = false
        return twoBtn2
    }()
    
    lazy var twoBtn3: UIButton = {
        let twoBtn3 = UIButton(type: .custom)
        twoBtn3.setImage(UIImage(named: "lianxiwomen"), for: .normal)
        twoBtn3.adjustsImageWhenHighlighted = false
        return twoBtn3
    }()
    
    lazy var twoBtn4: UIButton = {
        let twoBtn4 = UIButton(type: .custom)
        twoBtn4.setImage(UIImage(named: "gaunyuwomen"), for: .normal)
        twoBtn4.adjustsImageWhenHighlighted = false
        return twoBtn4
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(touxiang)
        scrollView.addSubview(phoneLabe)
        scrollView.addSubview(huiyuan)
        scrollView.addSubview(twoBtn)
        scrollView.addSubview(twoBtn1)
        scrollView.addSubview(twoBtn2)
        scrollView.addSubview(twoBtn3)
        scrollView.addSubview(twoBtn4)
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
            make.size.equalTo(CGSize(width: 70.lpix(), height: 70.lpix()))
            make.top.equalToSuperview().offset(StatusHeightManager.statusBarHeight + 24.lpix())
            make.left.equalToSuperview().offset(20.lpix())
        }
        
        phoneLabe.snp.makeConstraints { make in
            make.left.equalTo(touxiang.snp.right).offset(20.lpix())
            make.top.equalTo(touxiang.snp.top)
            make.height.equalTo(32.5.lpix())
        }
        
        huiyuan.snp.makeConstraints { make in
            make.top.equalTo(phoneLabe.snp.bottom).offset(15.lpix())
            make.left.equalTo(touxiang.snp.right).offset(20.lpix())
            make.size.equalTo(CGSize(width: 77.5.lpix(), height: 22.5.lpix()))
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(103.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(huiyuan.snp.bottom).offset(30.lpix())
        }
        
        twoBtn1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(twoBtn.snp.bottom).offset(30.lpix())
        }
        
        twoBtn2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(twoBtn1.snp.bottom).offset(20.lpix())
        }
        
        twoBtn3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(twoBtn2.snp.bottom).offset(20.lpix())
        }
        
        twoBtn4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(twoBtn3.snp.bottom).offset(20.lpix())
            make.bottom.equalToSuperview().offset(-125.lpix())
        }
        
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
        twoBtn4.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block4?()
        }).disposed(by: disposeBag)
    }
    
}
 