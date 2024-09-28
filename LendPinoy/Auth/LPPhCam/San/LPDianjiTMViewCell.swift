//
//  LPDianjiTMViewCell.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/6.
//

import UIKit
import RxSwift
import RxRelay

class LPDianjiTMViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var tapBlock: ((UIButton) -> Void)?
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 20)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "righticona")
        return icon
    }()
    
    lazy var timeBtn: UIButton = {
        let timeBtn = UIButton(type: .custom)
        timeBtn.contentHorizontalAlignment = .left
        timeBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22)
        timeBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
        return timeBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(timeBtn)
        makess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<crossingModel?>(value: nil)
    
    
    func makess() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-95)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
            make.size.equalTo(CGSize(width: 17, height: 17))
        }
        timeBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        timeBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.tapBlock?(self.timeBtn)
            }
        }).disposed(by: disposeBag)
        
        model.subscribe(onNext: { [weak self] model1 in
            guard let self = self, let model1 = model1 else { return }
            if let completely = model1.completely, !completely.isEmpty {
                self.timeBtn.setTitle(completely, for: .normal)
                self.timeBtn.setTitleColor(UIColor.init(hex: "#2CD7BB"), for: .normal)
            }else {
                self.timeBtn.setTitle(model1.met ?? "", for: .normal)
                self.timeBtn.setTitleColor(UIColor.init(hex: "#CFD9D8"), for: .normal)
            }
            self.nameLabel.text = model1.readily ?? ""
        }).disposed(by: disposeBag)
    }
    
}



