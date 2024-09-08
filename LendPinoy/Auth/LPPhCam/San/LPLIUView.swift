//
//  LPLIUView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/8.
//

import UIKit
import RxSwift
import RxRelay

class LPLIUView: LPJCView {
    
    var comfirmblock: (() -> Void)?
    
    var modelArray = BehaviorRelay<[crossingModel]>(value: [])
    
    var model1Array = BehaviorRelay<[crossingModel]?>(value: [])
    
    var model2Array = BehaviorRelay<[crossingModel]?>(value: [])
    
    var tapBlock: ((UIButton, crossingModel) -> Void)?
    
    var becameInfoBlock: ((String) -> Void)?
    
    lazy var navView: LPNavgationTwoView = {
        let navView = LPNavgationTwoView()
        navView.mBlock = { [weak self] btn in
            if btn == navView.eBtn {
                self?.becameInfoBlock?("1")
                if let model1Array = self?.model1Array.value {
                    self?.modelArray.accept(model1Array)
                }
            }else {
                self?.becameInfoBlock?("2")
                if let model2Array = self?.model2Array.value {
                    self?.modelArray.accept(model2Array)
                }
            }
        }
        return navView
    }()
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88.lpix()
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

extension LPLIUView: UITableViewDelegate {
    
    func makess() {
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
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
            make.top.equalTo(bgView1.snp.bottom).offset(5.lpix())
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
        return 120.lpix()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model1Array = model1Array.value, !model1Array.isEmpty else { return nil }
        let footView = UIView()
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 4.lpix()
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        btn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
        footView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.bottom.equalToSuperview()
            make.height.equalTo(60.lpix())
        }
        btn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.comfirmblock?()
            }
        }).disposed(by: disposeBag)
        return footView
    }
    
}
