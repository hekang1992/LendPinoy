//
//  LPOrdersView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/1.
//

import UIKit
import RxSwift

class LPOrdersView: UIView {
    
    let disposeBag = DisposeBag()
    
    var block: (() -> Void)?

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return scrollView
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setImage(UIImage(named: "Grouptwo"), for: .normal)
        twoBtn.adjustsImageWhenHighlighted = false
        return twoBtn
    }()
    
    lazy var twoBtn1: UIButton = {
        let twoBtn1 = UIButton(type: .custom)
        twoBtn1.setImage(UIImage(named: "jinxingzhong"), for: .normal)
        twoBtn1.adjustsImageWhenHighlighted = false
        return twoBtn1
    }()
    
    lazy var twoBtn2: UIButton = {
        let twoBtn2 = UIButton(type: .custom)
        twoBtn2.setImage(UIImage(named: "yuqiyem"), for: .normal)
        twoBtn2.adjustsImageWhenHighlighted = false
        return twoBtn2
    }()
    
    lazy var twoBtn3: UIButton = {
        let twoBtn3 = UIButton(type: .custom)
        twoBtn3.setImage(UIImage(named: "shibaipng"), for: .normal)
        twoBtn3.adjustsImageWhenHighlighted = false
        return twoBtn3
    }()
    
    lazy var twoBtn4: UIButton = {
        let twoBtn4 = UIButton(type: .custom)
        twoBtn4.setImage(UIImage(named: "huaniqngye"), for: .normal)
        twoBtn4.adjustsImageWhenHighlighted = false
        return twoBtn4
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
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

extension LPOrdersView {
    
    func makeupss() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(103.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalToSuperview().offset(StatusHeightManager.statusBarHeight + 4.lpix())
        }
        
        twoBtn1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.top.equalTo(twoBtn.snp.bottom).offset(30.lpix())
        }
        
        twoBtn2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(95.lpix())
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
            make.bottom.equalToSuperview().offset(-135.lpix())
        }
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?()
        }).disposed(by: disposeBag)
        
    }
    
    
}
