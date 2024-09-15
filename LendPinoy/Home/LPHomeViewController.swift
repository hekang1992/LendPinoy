//
//  LPHomeViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

class LPHomeViewController: LPBaseViewController {
    
    lazy var subView: LPSubHomeView = {
        let subView = LPSubHomeView()
        return subView
    }()
    
    lazy var manView: LPHubHomeView = {
        let manView = LPHubHomeView()
        return manView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addShuaxin()
        setupCallbacks()
    }
    
    private func setupViews() {
        [subView, manView].forEach { view.addSubview($0) }
        
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        manView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hideViews()
    }
    
    private func hideViews() {
        subView.isHidden = true
        manView.isHidden = true
    }
    
    private func setupCallbacks() {
        subView.block1 = { [weak self] ppid in
            self?.shenqingchanpin(form: ppid)
        }
        
        subView.block4 = { [weak self] pur in
            self?.genJuUrlPush(form: pur)
        }
        
        manView.block1 = { [weak self] pur in
            self?.genJuUrlPush(form: pur)
        }
        
        manView.block2 = { [weak self] model in
            self?.shenqingchanpin(form: model.hesitantly ?? "")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeInfo()
    }
    
}

extension LPHomeViewController {
    
    func homeInfo() {
        let man = LPRequestManager()
        let params = ["wandering": "product",
                      "home": "sub",
                      "strolled": String(Date().timeIntervalSince1970)]
        let pageUrl = "/lpinoy/sorry/mouse/little"
        
        man.uploadDataAPI(params: params, pageUrl: pageUrl, method: .get) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.subView.scrollView.mj_header?.endRefreshing()
                self.manView.tableView.mj_header?.endRefreshing()
            }
            switch result {
            case .success(let success):
                self.handleSuccess(success.itself)
            case .failure(let error):
                print("Failed to fetch data: \(error)")
            }
        }
    }

    private func handleSuccess(_ homeModel: itselfModel) {
        if homeModel.forests?.separately == "yamada2" {
            showSubView(with: homeModel)
        } else {
            showManView(with: homeModel)
        }
    }

    private func showSubView(with homeModel: itselfModel) {
        subView.isHidden = false
        manView.isHidden = true
        subView.homeSubModel.accept(homeModel)
        subView.lunboView.reloadData()
    }

    private func showManView(with homeModel: itselfModel) {
        subView.isHidden = true
        manView.isHidden = false
        manView.homeSubModel.accept(homeModel)
        manView.lunboView.reloadData()
    }
    
    func addShuaxin() {
        subView.scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadInfo))
        manView.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadInfo))
    }
    
    @objc func loadInfo() {
        homeInfo()
    }
    
}
