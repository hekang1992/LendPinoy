//
//  LPTwoViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/4.
//

import UIKit

class LPTwoViewController: LPBaseViewController {
    
    lazy var twoView: LPTwoView = {
        let twoView = LPTwoView()
        return twoView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        twoView.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        qinqiuAInfo()
    }

}

struct ActionModel {
    let title: String?
    let icon: String?
    let desc: String?
    init(title: String?, icon: String?, desc: String?) {
        self.title = title
        self.icon = icon
        self.desc = desc
    }
}

extension LPTwoViewController {
    
    func qinqiuAInfo() {
        
        let model1 = ActionModel(title: "ID Verification", icon: "Verification", desc: "Please ensure that the uploaded ID card type matches the selected ID card!")
        
        let model2 = ActionModel(title: "Facial Recognition", icon: "Recognition", desc: "Please ensure good lighting, maintain a natural expression, and stay relatively still!")
        
        let array = [model1,model2]
        self.twoView.modelArray.accept(array)
    }
    
}
