//
//  LPOrdersViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit

class LPOrdersViewController: LPBaseViewController {
    
    lazy var olistView: LPOrdersView = {
        let olistView = LPOrdersView()
        return olistView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(olistView)
        olistView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LPTabBarManager.showTabBar()
    }
    
}


extension LPOrdersViewController {
    
    func tap() {
        olistView.block = { [weak self] li in
            let oli = LPOrderListViewController()
            oli.li.accept(li)
            self?.navigationController?.pushViewController(oli, animated: true)
        }
    }
    
}
