//
//  LPHomeViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit
import MJRefresh

class LPHomeViewController: LPBaseViewController {
    
    lazy var subView: LPSubHomeView = {
        let subView = LPSubHomeView()
        return subView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        homeInfo()
        addShuaxin()
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
                print("homeModel>>>>>>>\(homeModel)")
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
