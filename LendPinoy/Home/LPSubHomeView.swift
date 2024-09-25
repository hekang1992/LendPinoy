//
//  LPSubHomeView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/1.
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
        lunboView.automaticSlidingInterval = 2.0
        lunboView.register(LPLunBoViewCell.self, forCellWithReuseIdentifier: "LPLunBoViewCell")
        return lunboView
    }()
    
    lazy var monIcon: UIImageView = {
        let monIcon = UIImageView()
        monIcon.image = UIImage(named: "moneypinf")
        monIcon.isUserInteractionEnabled = true
        return monIcon
    }()
    
    lazy var offBtn: UIButton = {
        let offBtn = UIButton(type: .custom)
        offBtn.isSelected = true
        offBtn.setImage(UIImage(named: "onpnge"), for: .selected)
        offBtn.setImage(UIImage(named: "offpnge"), for: .normal)
        return offBtn
    }()
    
    lazy var timelabel: UILabel = {
        let timelabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 12)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        let timeUpdater = TimeUpdater { timeStr in
            timelabel.text = timeStr
        }
        timeUpdater.startUpdatingTime()
        return timelabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setImage(UIImage(named: "jinduimagea"), for: .normal)
        applyBtn.adjustsImageWhenHighlighted = false
        return applyBtn
    }()
    
    lazy var poIcon: UIImageView = {
        let poIcon = UIImageView()
        poIcon.image = UIImage(named: "peoimagePA")
        return poIcon
    }()
    
    lazy var sceBtn: UIButton = {
        let sceBtn = UIButton(type: .custom)
        sceBtn.setImage(UIImage(named: "secimadef"), for: .normal)
        sceBtn.adjustsImageWhenHighlighted = false
        return sceBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(lunboView)
        scrollView.addSubview(monIcon)
        monIcon.addSubview(timelabel)
        monIcon.addSubview(offBtn)
        scrollView.addSubview(applyBtn)
        scrollView.addSubview(poIcon)
        scrollView.addSubview(sceBtn)
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
        lunboView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 10)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(103)
        }
        monIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(lunboView.snp.left).offset(5)
            make.height.equalTo(114.5)
            make.top.equalTo(lunboView.snp.bottom).offset(27.5)
        }
        timelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2.5)
            make.left.equalToSuperview()
            make.height.equalTo(15)
        }
        offBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 35, height: 20))
        }
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(monIcon.snp.bottom).offset(30)
            make.left.equalTo(monIcon.snp.left)
            make.height.equalTo(162.5)
        }
        poIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(applyBtn.snp.bottom).offset(30)
            make.left.equalTo(monIcon.snp.left)
            make.height.equalTo(145)
        }
        sceBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(poIcon.snp.bottom).offset(18)
            make.left.equalTo(monIcon.snp.left)
            make.height.equalTo(133)
            make.bottom.equalToSuperview().offset(-125)
        }
    }
    
    func tapClick() {
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if let homeSubModel = self.homeSubModel.value, let ppid = homeSubModel.forests?.delivery?[0].hesitantly {
                self.block1?(ppid, homeSubModel.erase ?? "")
            }
        }).disposed(by: disposeBag)
        
        sceBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        
        offBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.offBtn.isSelected.toggle()
            if let isSelected = self?.offBtn.isSelected {
                ViewCycleManager.addCycView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if isSelected {
                        ToastUtility.showToast(message: "Text message notifications are enabled")
                    }else {
                        ToastUtility.showToast(message: "Text message notifications are disabled")
                    }
                    ViewCycleManager.hideCycView()
                }
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
