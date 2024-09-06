//
//  LPHomeViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit
import MJRefresh
import RxRelay

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
        
        // Do any additional setup after loading the view.
        view.addSubview(subView)
        view.addSubview(manView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        manView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        manView.isHidden = true
        subView.isHidden = true
        addShuaxin()
        subView.block1 = { [weak self] ppid in
            self?.shenqingchanpin(form: ppid)
        }
        subView.block4 = { [weak self] pur in
            self?.genJuUrlPush(form: pur)
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
        man.uploadDataAPI(params: ["wandering": "product",
                                "home": "sub",
                                   "strolled": String(Date().timeIntervalSince1970)],
                       pageUrl: "/lpinoy/sorry/mouse/little",
                       method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                let homeModel = success.itself
                if homeModel.forests?.separately == "yamada2" {//one
                    self?.subView.isHidden = false
                    self?.manView.isHidden = true
                } else {//two
                    self?.subView.isHidden = true
                    self?.manView.isHidden = false
                }
                self?.subView.homeSubModel.accept(homeModel)
                self?.subView.lunboView.reloadData()
                self?.subView.scrollView.mj_header?.endRefreshing()
                break
            case .failure(_):
                self?.subView.scrollView.mj_header?.endRefreshing()
                break
            }
        }
    }
    
    func addShuaxin() {
        subView.scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadInfo))
    }
    
    @objc func loadInfo() {
        homeInfo()
    }
    
}
