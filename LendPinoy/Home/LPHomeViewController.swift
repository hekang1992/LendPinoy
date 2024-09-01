//
//  LPHomeViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/29.
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
        
        addShuaxin()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LPHomeViewController {
    
    func addShuaxin() {
        subView.scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadInfo))
    }
    
    
    @objc func loadInfo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.subView.scrollView.mj_header?.endRefreshing()
        }
    }
    
}
