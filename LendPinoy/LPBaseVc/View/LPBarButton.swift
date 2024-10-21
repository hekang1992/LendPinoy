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

    var block: ((LPBarButton) -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var iconBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.contentMode = .center
        button.adjustsImageWhenHighlighted = false
        return button
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
        iconBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block?(self)
        }).disposed(by: disposeBag)
    }
    
    func setTabBarImage(url: String, title: String) {
        iconBtn.setBackgroundImage(UIImage(named: url), for: .normal)
    }
    
}
