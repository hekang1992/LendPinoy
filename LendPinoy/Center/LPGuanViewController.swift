//
//  LPGuanViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/18.
//

import UIKit

class LPGuanViewController: LPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNavView(title: "About Us")
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        makess()
        
        
    }

}


extension LPGuanViewController {
    
    func makess() {
        
        let icon = UIImageView()
        icon.image = UIImage(named: "centericon")
        view.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(self.navView.snp.bottom).offset(30.lpix())
            make.size.equalTo(CGSize(width: 60.lpix(), height: 60.lpix()))
        }
        
        
        let naLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 24.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        naLabel.text = "LendPinoy"
        view.addSubview(naLabel)
        naLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20.lpix())
            make.top.equalTo(icon.snp.top)
            make.height.equalTo(26.lpix())
        }
        
        let navLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 22.lpix())!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        navLabel.text = "v 1.0.0"
        view.addSubview(navLabel)
        navLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20.lpix())
            make.bottom.equalTo(icon.snp.bottom)
            make.height.equalTo(26.lpix())
        }
        
    }
    
}
