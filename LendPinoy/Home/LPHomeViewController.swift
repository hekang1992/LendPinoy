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
        homeInfo()
        addShuaxin()
        subView.block1 = { [weak self] ppid in
            self?.shenqingchanpin(form: ppid)
        }
    }
    
}

extension LPHomeViewController {
    
    func homeInfo() {
        let man = LPRequestManager()
        man.requestAPI(params: ["wandering": "product",
                                "home": "sub",
                                "strolled": Date()], 
                       pageUrl: "/lpinoy/sorry/mouse/little",
                       method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                let homeModel = success.itself
                if homeModel.forests?.separately == "yamada2" {//oneHome
                    self?.subView.isHidden = false
                    self?.manView.isHidden = true
                } else {//twoHome
                    self?.subView.isHidden = true
                    self?.manView.isHidden = false
                }
                self?.subView.homeSubModel.accept(homeModel)
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
