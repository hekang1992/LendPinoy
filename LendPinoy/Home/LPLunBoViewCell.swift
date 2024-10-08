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


class LPFengXianViewCell: FSPagerViewCell {
    
    let disposeBag = DisposeBag()

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "feingiu")
        return icon
    }()
    
    lazy var ttll: UILabel = {
        let ttll = UILabel.cjLabel(font: UIFont(name: regular_MarketFresh, size: 18)!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        ttll.numberOfLines = 0
        return ttll
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
        icon.addSubview(ttll)
        icon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ttll.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-96)
        }
        model.subscribe(onNext: { [weak self] model1 in
            self?.ttll.text = model1?.frown ?? ""
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<deliveryModel?>(value: nil)
    
}
