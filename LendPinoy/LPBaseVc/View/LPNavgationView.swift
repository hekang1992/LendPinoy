//
//  LPNavgationView.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/1.
//

import UIKit
import RxSwift

class LPNavgationView: UIView {
    
    let disposeBag = DisposeBag()
    
    var block: (() -> Void)?

    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "leftjiantoupn"), for: .normal)
        return backBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 18.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .center)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(titleLabel)
        backBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.size.equalTo(CGSize(width: 34.lpix(), height: 34.lpix()))
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20.lpix())
        }
        tap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LPNavgationView {
    
    func tap() {
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?()
        }).disposed(by: disposeBag)
    }
    
}
