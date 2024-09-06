//
//  FristVcView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/4.
//

import UIKit
import RxRelay
import RxSwift

class FristVcView: LPJCView {
    
    var block: ((String) -> Void)?
    
    var strArray = BehaviorRelay<[String]>(value: [])
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = UIColor.init(hex: "#F3FBFA")
        bgView1.layer.cornerRadius = 4.lpix()
        return bgView1
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "dunpaiopp")
        return icon
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 12.lpix())!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        descLabel.text = "We will provide comprehensive protection for your privacy data."
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        navView.titleLabel.text = "Select ID type"
        return navView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88.lpix()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(FristViewCell.self, forCellReuseIdentifier: "FristViewCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navView)
        addSubview(bgView1)
        bgView1.addSubview(icon)
        bgView1.addSubview(descLabel)
        addSubview(tableView)
        makess()
        bindss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FristVcView: UITableViewDelegate {
    
    func makess() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
        bgView1.snp.makeConstraints { make in
            make.top.equalTo(navView.snp.bottom).offset(5.lpix())
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(35.lpix())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.lpix())
            make.size.equalTo(CGSize(width: 14.lpix(), height: 18.lpix()))
        }
        descLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15.lpix())
            make.left.equalTo(icon.snp.right).offset(10.lpix())
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bgView1.snp.bottom).offset(20.lpix())
        }
    }
    
    func bindss() {
        strArray
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "FristViewCell", cellType: FristViewCell.self)) { index, model, cell in
                cell.str.accept(model)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self] model in
            self?.block?(model)
        }).disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}
