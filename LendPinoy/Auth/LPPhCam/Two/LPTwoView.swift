//
//  LPTwoView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/4.
//

import UIKit
import RxRelay
import RxSwift

class LPTwoView: LPJCView {
    
    var modelArray = BehaviorRelay<[ActionModel?]>(value: [])
    
    var startblock: (() -> Void)?
    
    var cellClicjblock: ((Int) -> Void)?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        navView.titleLabel.text = "Verification"
        return navView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(LPTwoCell.self, forCellReuseIdentifier: "LPTwoCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navView)
        addSubview(tableView)
        makess()
        bindss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPTwoView: UITableViewDelegate {
    
    func makess() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom).offset(10)
        }
    }
    
    func bindss() {
        modelArray
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "LPTwoCell", cellType: LPTwoCell.self)) { index, model ,cell in
                cell.model.accept(model)
                cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.cellClicjblock?(indexPath.row)
        }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4
        btn.setTitle("Start", for: .normal)
        btn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        btn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22)
        footView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        btn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.startblock?()
            }
        }).disposed(by: disposeBag)
        return footView
    }
    
}
