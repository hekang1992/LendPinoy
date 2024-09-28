//
//  LPLunBoViewCell.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/1.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa
import Kingfisher

class LPLunBoViewCell: FSPagerViewCell {
    
    let disposeBag = DisposeBag()

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
        
        model.subscribe(onNext: { [weak self] model in
            self?.icon.kf.setImage(with: URL(string: model?.fine ?? ""))
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<deliveryModel?>(value: nil)
    
}

