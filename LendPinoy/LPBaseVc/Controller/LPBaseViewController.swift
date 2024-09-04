//
//  LPBaseViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
//

import UIKit
import RxSwift

class LPBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        return navView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }

}

extension LPBaseViewController {
    
    func addNavView(title: String) {
        view.addSubview(navView)
        navView.titleLabel.text = title
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusHeightManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
    }

}
