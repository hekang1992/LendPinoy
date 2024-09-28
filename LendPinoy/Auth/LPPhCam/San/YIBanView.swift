//
//  YIBanView.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/6.
//

import UIKit
import RxSwift
import RxRelay

class YIBanView: LPJCView {
    
    var comfirmblock: (() -> Void)?
    
    var modelArray = BehaviorRelay<[crossingModel]>(value: [])
    
    var tapBlock: ((UIButton, crossingModel) -> Void)?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        return navView
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = UIColor.init(hex: "#F3FBFA")
        bgView1.layer.cornerRadius = 4
        return bgView1
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "dunpaiopp")
        return icon
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 12)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        descLabel.text = "We will provide comprehensive protection for your privacy data."
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(LPTextViewCell.self, forCellReuseIdentifier: "LPTextViewCell")
        tableView.register(LPDianjiTMViewCell.self, forCellReuseIdentifier: "LPDianjiTMViewCell")
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

extension YIBanView: UITableViewDelegate {
    
    func makess() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(35)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 14, height: 18))
        }
        descLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.left.equalTo(icon.snp.right).offset(10)
        }
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bgView1.snp.bottom).offset(5)
        }
    }
    
    func bindss() {
        
        modelArray
            .asObservable()
            .bind(to: tableView.rx.items) { tableView, index, model in
                let sbc = model.photo ?? ""
                if sbc == "pointing2" {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "LPTextViewCell", for: IndexPath(row: index, section: 0)) as? LPTextViewCell  {
                        cell.model.accept(model)
                        cell.backgroundColor = .clear
                        cell.selectionStyle = .none
                        return cell
                    }
                } else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "LPDianjiTMViewCell", for: IndexPath(row: index, section: 0)) as? LPDianjiTMViewCell  {
                        cell.model.accept(model)
                        cell.backgroundColor = .clear
                        cell.selectionStyle = .none
                        cell.tapBlock = { [weak self] btn in
                            self?.tapBlock?(btn, model)
                        }
                        return cell
                    }
                }
                return UITableViewCell()
            }.disposed(by: disposeBag)
        
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
        guard !modelArray.value.isEmpty else { return nil }
        let footView = UIView()
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4
        btn.setTitle("Confirm", for: .normal)
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
                self.comfirmblock?()
            }
        }).disposed(by: disposeBag)
        return footView
    }
    
}
