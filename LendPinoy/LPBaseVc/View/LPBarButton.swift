//
//  LPBarButton.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LPBarButton: UIControl {
    
    let buttonW = (SCREEN_WIDTH - 40) / 3

    var block: ((LPBarButton) -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var iconBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.contentMode = .center
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 14)!, textColor: UIColor(hex: "#CFD9D8"), textAlignment: .left)
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    private func addSubviews() {
        addSubview(iconBtn)
        addSubview(nameLabel)
        iconBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(29)
            make.size.equalTo(CGSize(width: 21, height: 21))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconBtn.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 50, height: 15))
        }
        iconBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?(self)
        }).disposed(by: disposeBag)
    }
    
    func setTabBarImage(url: String, title: String) {
        nameLabel.text = title
        iconBtn.setImage(UIImage(named: url), for: .normal)
    }
    
}
