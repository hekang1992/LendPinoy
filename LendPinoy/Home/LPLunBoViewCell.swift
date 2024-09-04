//
//  LPLunBoViewCell.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/1.
//

import UIKit
import FSPagerView

class LPLunBoViewCell: FSPagerViewCell {

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

