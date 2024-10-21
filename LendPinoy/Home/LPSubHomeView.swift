//
//  LPSubHomeView.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/1.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class LPSubHomeView: LPJCView {
    
    var block1: ((String, String) -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: ((UIButton) -> Void)?
    
    var block4: ((String) -> Void)?
    
    var block5: (() -> Void)?
    
    var homeSubModel = BehaviorRelay<itselfModel?>(value: nil)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return scrollView
    }()
    
    lazy var lunboView: FSPagerView = {
        let lunboView = FSPagerView()
        lunboView.isInfinite = true
        lunboView.delegate = self
        lunboView.dataSource = self
        lunboView.backgroundColor = .white
        lunboView.register(LPLunBoViewCell.self, forCellWithReuseIdentifier: "LPLunBoViewCell")
        return lunboView
    }()
    
    lazy var iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "bgimagehomee")
        return iconImage
    }()
     
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setBackgroundImage(UIImage(named: "appleBTfim"), for: .normal)
        applyBtn.adjustsImageWhenHighlighted = false
        return applyBtn
    }()

    lazy var ssLabel: UILabel = {
        let ssLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 16)!, textColor: UIColor.init(hex: "#1F385F"), textAlignment: .left)
        ssLabel.text = "Application Procedure"
        return ssLabel
    }()
    
    lazy var iconImage1: UIImageView = {
        let iconImage1 = UIImageView()
        iconImage1.image = UIImage(named: "icomimage1")
        return iconImage1
    }()
    
    lazy var iconImage2: UIImageView = {
        let iconImage2 = UIImageView()
        iconImage2.image = UIImage(named: "icomimagefda")
        return iconImage2
    }()
    
    lazy var iconImage3: UIImageView = {
        let iconImage3 = UIImageView()
        iconImage3.image = UIImage(named: "icomimageth")
        return iconImage3
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(iconImage)
        scrollView.addSubview(lunboView)
        scrollView.addSubview(applyBtn)
        scrollView.addSubview(ssLabel)
        scrollView.addSubview(iconImage1)
        scrollView.addSubview(iconImage2)
        scrollView.addSubview(iconImage3)
        makess()
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPSubHomeView {
    
    func makess() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(570)
        }
        lunboView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight - 4)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(86)
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(iconImage.snp.bottom).offset(-42)
            make.size.equalTo(CGSize(width: 280, height: 58))
        }
        ssLabel.snp.makeConstraints { make in
            make.top.equalTo(applyBtn.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(19)
        }
        iconImage1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(ssLabel.snp.bottom).offset(15)
            make.height.equalTo(110)
        }
        iconImage2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(iconImage1.snp.bottom).offset(15)
            make.height.equalTo(110)
        }
        iconImage3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(iconImage2.snp.bottom).offset(15)
            make.height.equalTo(110)
            make.bottom.equalToSuperview().offset(-115)
        }
    }
    
    func tapClick() {
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if let homeSubModel = self.homeSubModel.value, let ppid = homeSubModel.forests?.delivery?[0].hesitantly {
                self.block1?(ppid, homeSubModel.erase ?? "")
            }
        }).disposed(by: disposeBag)
       
        self.homeSubModel.subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            if model?.purse?.delivery?.count == 1 {
                self.lunboView.isInfinite = false
                self.lunboView.automaticSlidingInterval = 0
            }else {
                self.lunboView.isInfinite = true
                self.lunboView.automaticSlidingInterval = 2
            }
        }).disposed(by: disposeBag)
       
    }
    
}

extension LPSubHomeView: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        let modelArray = homeSubModel.value?.purse?.delivery
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "LPLunBoViewCell", at: index) as? LPLunBoViewCell else { return FSPagerViewCell() }
        cell.model.accept(homeSubModel.value?.purse?.delivery?[index])
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let model = homeSubModel.value?.purse?.delivery?[index]
        if let papee = model?.payment, !papee.isEmpty {
            self.block4?(papee)
        }else {
            return
        }
    }
}
