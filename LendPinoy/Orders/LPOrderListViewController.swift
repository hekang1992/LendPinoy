//
//  LPOrderListViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/10.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class LPOrderListViewController: LPBaseViewController {
    
    var li = BehaviorRelay<String>(value: "")
    
    lazy var listView: LPOrderListView = {
        let listView = LPOrderListView()
        return listView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        listView.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        listView.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(abdo))
        listView.tableView.mj_header?.beginRefreshing()
        listView.block = {
            NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
        }
        listView.tapBlock = { [weak self] cell, model in
            self?.genJuUrlPush(form: model.precisely ?? "")
        }
        listView.bloc1k = { [weak self] piUl in
            if !piUl.isEmpty {
                self?.genJuUrlPush(form: piUl)
            }
        }
    }
    
}
//interesting
extension LPOrderListViewController {
    
    @objc func abdo() {
        dedaoInfo()
    }
    
    func dedaoInfo() {
        let man = LPRequestManager()
        man.requestAPI(params: ["skin": li.value, "com": "q", "data": "json"], pageUrl: "/lpinoy/badof/followinghidejis/opening", method: .post) { result in
            switch result {
            case .success(let success):
                if let modelArray = success.itself.dazed {
                    self.listView.modelArray.accept(modelArray)
                }
                self.listView.tableView.mj_header?.endRefreshing()
                break
            case .failure(let failure):
                self.listView.tableView.mj_header?.endRefreshing()
                print("failure:\(failure)")
                break
            }
        }
    }
    
}
