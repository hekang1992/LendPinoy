//
//  LPADBListView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/9.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class LPADBListView: LPJCView {
    
    var adblock: (() -> Void)?
    
    var adbcclock: ((String) -> Void)?
    
    var modeArray = BehaviorRelay<[dazedModel]>(value: [])
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(LPADBListCell.self, forCellReuseIdentifier: "LPADBListCell")
        return tableView
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<dazedModel>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "LPADBListCell", for: indexPath) as? LPADBListCell
            if let cell = cell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model.accept(item)
            }
            return cell ?? UITableViewCell()
        },
        titleForHeaderInSection: { dataSource, index in
            return nil
        }
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        makessinof()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LPADBListView: UITableViewDelegate {
    
    func makessinof() {
        modeArray
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(deliveryModel.self).subscribe(onNext: {  [weak self] model in
            self?.adbcclock?(model.confirm ?? "")
        }).disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 24)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
//        if section == 0 {
//            label.text = "(E-Wallet)"
//        }else {
//            label.text = "(Bank)"
//        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(28)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == modeArray.value.count - 1 {
            return 80
        }else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == modeArray.value.count - 1 {
            let footView = UIView()
            let btn = UIButton(type: .custom)
            btn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitle("Add Payment Methods", for: .normal)
            btn.backgroundColor = UIColor.init(hex: "#2CD7BB")
            btn.layer.cornerRadius = 4
            btn.layer.masksToBounds = true
            footView.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(20)
                make.left.equalToSuperview().offset(20)
                make.height.equalTo(60)
            }
            btn.rx.tap.subscribe(onNext: { [weak self] in
                self?.adblock?()
            }).disposed(by: disposeBag)
            return footView
        }else {
            return nil
        }
    }
    
}
