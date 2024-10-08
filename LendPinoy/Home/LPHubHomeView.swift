//
//  LPHubHomeView.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/1.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class LPHubHomeView: LPJCView {
    
    var block1: ((String) -> Void)?
    
    var block2: ((deliveryModel) -> Void)?
    
    var block3: ((String) -> Void)?
    
    var homeSubModel = BehaviorRelay<itselfModel?>(value: nil)
    
    var homeVipModel = BehaviorRelay<itselfModel?>(value: nil)
    
    var vpType = BehaviorRelay<String>(value: "1")
    
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
    
    lazy var fengXianView: FSPagerView = {
        let fengXianView = FSPagerView()
        fengXianView.isInfinite = true
        fengXianView.delegate = self
        fengXianView.dataSource = self
        fengXianView.backgroundColor = .white
        fengXianView.automaticSlidingInterval = 2.0
        fengXianView.register(LPFengXianViewCell.self, forCellWithReuseIdentifier: "LPFengXianViewCell")
        return fengXianView
    }()
    
    lazy var proBtn: UIButton = {
        let proBtn = UIButton(type: .custom)
        proBtn.contentHorizontalAlignment = .left
        proBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 24)
        proBtn.setTitle("Products", for: .normal)
        proBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .normal)
        return proBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(HomeListViewCell.self, forCellReuseIdentifier: "HomeListViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        homeSubModel
            .compactMap {
                $0?.fast_list?.delivery
            }
            .bind(to: tableView.rx.items(cellIdentifier: "HomeListViewCell", cellType: HomeListViewCell.self)) { [weak self] row, model, cell in
                if self?.homeSubModel.value?.fast_list?.delivery?.count == 1 {
                    cell.lineView.isHidden = true
                }else {
                    cell.lineView.isHidden = false
                }
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.model.accept(model)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(deliveryModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            self.block2?(model)
        }).disposed(by: disposeBag)
        
        makess()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPHubHomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model = homeSubModel.value
        if let modelArray = model?.overdue?.delivery, modelArray.count > 0 {
            return StatusManager.statusBarHeight + 245
        }else {
            return StatusManager.statusBarHeight + 195
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = homeSubModel.value
        let headView = UIView()
        if let modelArray = model?.overdue?.delivery, modelArray.count > 0 {
            headView.addSubview(lunboView)
            headView.addSubview(fengXianView)
            headView.addSubview(proBtn)
            lunboView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 10)
                make.left.equalToSuperview().offset(15)
                make.height.equalTo(103)
            }
            fengXianView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(lunboView.snp.bottom).offset(12.5)
                make.left.equalToSuperview().offset(15)
                make.height.equalTo(72)
            }
            proBtn.snp.makeConstraints { make in
                make.top.equalTo(fengXianView.snp.bottom).offset(12.5)
                make.left.equalToSuperview().offset(15)
                make.size.equalTo(CGSize(width: 120, height: 30))
            }
        }else {
            headView.addSubview(lunboView)
            headView.addSubview(proBtn)
            lunboView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 10)
                make.left.equalToSuperview().offset(15)
                make.height.equalTo(103)
            }
            proBtn.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-20)
                make.left.equalToSuperview().offset(15)
                make.size.equalTo(CGSize(width: 120, height: 30))
            }
        }
        return headView
    }
    
    func makess() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.homeSubModel.subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            if model?.purse?.delivery?.count == 1 {
                self.lunboView.isInfinite = false
                self.lunboView.automaticSlidingInterval = 0
            }else {
                self.lunboView.isInfinite = true
                self.lunboView.automaticSlidingInterval = 2
            }
            if model?.overdue?.delivery?.count == 1 {
                self.fengXianView.isInfinite = false
                self.fengXianView.automaticSlidingInterval = 0
            }else {
                self.fengXianView.isInfinite = true
                self.fengXianView.automaticSlidingInterval = 2
            }
        }).disposed(by: disposeBag)
        
    }
    
}

extension LPHubHomeView: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        var modelArray: [deliveryModel]?
        if pagerView == lunboView {
             modelArray = homeSubModel.value?.purse?.delivery
        }else {
             modelArray = homeSubModel.value?.overdue?.delivery
        }
        return modelArray?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        if pagerView == lunboView {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "LPLunBoViewCell", at: index) as? LPLunBoViewCell else { return FSPagerViewCell() }
            cell.model.accept(homeSubModel.value?.purse?.delivery?[index])
            return cell
        } else {
            guard let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "LPFengXianViewCell", at: index) as? LPFengXianViewCell else { return FSPagerViewCell() }
            cell.model.accept(homeSubModel.value?.overdue?.delivery?[index])
            return cell
        }
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        var model: deliveryModel?
        if pagerView == lunboView {
            model = homeSubModel.value?.purse?.delivery?[index]
        }else {
            model = homeSubModel.value?.overdue?.delivery?[index]
        }
        if let papee = model?.payment, !papee.isEmpty {
            self.block1?(papee)
        }else {
            return
        }
    }
}
