//
//  LPTwoView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/4.
//

import UIKit
import RxRelay
import RxSwift

class LPTwoView: UIView {
    
    let disposeBag = DisposeBag()
    
    var modelArray = BehaviorRelay<[ActionModel]>(value: [])
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        navView.titleLabel.text = "Verification"
        return navView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88.lpix()
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
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom).offset(10.lpix())
        }
    }
    
    func bindss() {
        
        modelArray
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "LPTwoCell", cellType: LPTwoCell.self)) { index, model ,cell in
                cell.model.accept(model)
                cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self] model in
            print("model>>>>>\(model)")
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
        return 120.lpix()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4.lpix()
        btn.setTitle("Start", for: .normal)
        btn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        btn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
        footView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.bottom.equalToSuperview()
            make.height.equalTo(60.lpix())
        }
        return footView
    }
    
}