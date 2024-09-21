//
//  LPGuanViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/18.
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
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(self.navView.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        
        let naLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 24)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        naLabel.text = "LendPinoy"
        view.addSubview(naLabel)
        naLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20)
            make.top.equalTo(icon.snp.top)
            make.height.equalTo(26)
        }
        
        let navLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 22)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        navLabel.text = "v 1.0.0"
        view.addSubview(navLabel)
        navLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(20)
            make.bottom.equalTo(icon.snp.bottom)
            make.height.equalTo(26)
        }
        
    }
    
}
