//
//  LPOrderListView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/10.
//

import UIKit
import RxSwift
import RxRelay

class LPOrderListView: LPJCView {
    
    var modelArray = BehaviorRelay<[dazedModel]>(value: [])
    
    var tapBlock: ((LPOrderListCell, dazedModel) -> Void)?
    
    var block: (() -> Void)?
    
    var bloc1k: ((String) -> Void)?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        navView.titleLabel.text = "Bill Review"
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
        tableView.register(LPOrderListCell.self, forCellReuseIdentifier: "LPOrderListCell")
        return tableView
    }()
    
    lazy var wsView: WSView = {
        let wsView = WSView()
        wsView.block = { [weak self] in
            self?.block?()
        }
        return wsView
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

extension LPOrderListView: UITableViewDelegate {
    
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
        
        addSubview(self.wsView)
        self.wsView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bgView1.snp.bottom).offset(5.lpix())
        }
        modelArray
            .asObservable()
            .bind(to: tableView.rx.items) { tableView, index, model in
                if let cell = tableView.dequeueReusableCell(withIdentifier: "LPOrderListCell", for: IndexPath(row: index, section: 0)) as? LPOrderListCell  {
                    cell.model.accept(model)
                    cell.backgroundColor = .clear
                    cell.selectionStyle = .none
                    self.wsView.removeFromSuperview()
                    cell.tapoBlock = { [weak self] str in
                        self?.bloc1k?(str)
                    }
                    return cell
                }
                return UITableViewCell()
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            if let cell = self?.tableView.cellForRow(at: indexPath) as? LPOrderListCell, let cmodel = self?.modelArray.value[indexPath.row] {
                self?.tapBlock?(cell, cmodel)
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}
