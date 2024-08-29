//
//  PATabBarButton.swift
//  Pesoin
//
//  Created by apple on 2024/7/2.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PATabBarButton: UIControl {
    
    let buttonW = (SCREEN_WIDTH - 40.lpix()) / 3

    var block: ((PATabBarButton) -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var iconBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.contentMode = .center
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: MarketFreshBold_Font, size: 14.lpix())!, textColor: UIColor(hex: "#CFD9D8"), textAlignment: .left)
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
            make.left.equalToSuperview().offset(29.lpix())
            make.size.equalTo(CGSize(width: 21.lpix(), height: 21.lpix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconBtn.snp.right).offset(5.lpix())
            make.size.equalTo(CGSize(width: 50.lpix(), height: 15.lpix()))
        }
        iconBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.block?(self)
            }
        }).disposed(by: disposeBag)
    }
    
    func setTabBarImage(url: String, title: String) {
        nameLabel.text = title
        iconBtn.setImage(UIImage(named: url), for: .normal)
    }
    
}
