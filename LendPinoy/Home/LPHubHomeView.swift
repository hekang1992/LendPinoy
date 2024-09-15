//
//  LPHubHomeView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/1.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

class LPHubHomeView: LPJCView {
    
    var block1: ((String) -> Void)?
    
    var block2: ((deliveryModel) -> Void)?
    
    var homeSubModel = BehaviorRelay<itselfModel?>(value: nil)
    
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
    
    lazy var proBtn: UIButton = {
        let proBtn = UIButton(type: .custom)
        proBtn.contentHorizontalAlignment = .left
        proBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 24.lpix())
        proBtn.setTitle("Products", for: .normal)
        proBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .normal)
        return proBtn
    }()
    
    lazy var tickBtn: UIButton = {
        let tickBtn = UIButton(type: .custom)
        tickBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 24.lpix())
        tickBtn.setTitle("Top Picks", for: .normal)
        tickBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
        return tickBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88.lpix()
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
                $0?.forests?.delivery
            }
            .bind(to: tableView.rx.items(cellIdentifier: "HomeListViewCell", cellType: HomeListViewCell.self)) { [weak self] row, model, cell in
                if self?.homeSubModel.value?.forests?.delivery?.count == 1 {
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
        return StatusManager.statusBarHeight + 195.lpix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(lunboView)
        headView.addSubview(proBtn)
//        headView.addSubview(tickBtn)
        lunboView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 10.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.height.equalTo(103.lpix())
        }
        proBtn.snp.makeConstraints { make in
            make.top.equalTo(lunboView.snp.bottom).offset(35.lpix())
            make.left.equalToSuperview().offset(15.lpix())
            make.size.equalTo(CGSize(width: 120.lpix(), height: 30.lpix()))
        }
//        tickBtn.snp.makeConstraints { make in
//            make.top.equalTo(lunboView.snp.bottom).offset(35.lpix())
//            make.left.equalTo(proBtn.snp.right).offset(40.lpix())
//            make.size.equalTo(CGSize(width: 120.lpix(), height: 30.lpix()))
//        }
        return headView
    }
    
    func makess() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        proBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.updateButtonColors(selectedButton: self?.proBtn, deselectedButton: self?.tickBtn)
            })
            .disposed(by: disposeBag)
        
        tickBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.updateButtonColors(selectedButton: self?.tickBtn, deselectedButton: self?.proBtn)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func updateButtonColors(selectedButton: UIButton?, deselectedButton: UIButton?) {
        selectedButton?.setTitleColor(UIColor.init(hex: "#303434"), for: .normal)
        deselectedButton?.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
    }
    
}

extension LPHubHomeView: FSPagerViewDataSource, FSPagerViewDelegate {
    
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
            self.block1?(papee)
        }else {
            return
        }
    }
}
