//
//  FristViewCell.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/4.
//

import UIKit
import RxRelay
import RxSwift

class FristViewCell: UITableViewCell {
    
    var str = BehaviorRelay<String?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.lpix()
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 20.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var iocn: UIImageView = {
        let iocn = UIImageView()
        iocn.image = UIImage(named: "righticona")
        return iocn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(iocn)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(50.lpix())
            make.height.equalTo(80.lpix())
            make.bottom.equalToSuperview().offset(-20.lpix())
        }
        iocn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().offset(-50.lpix())
            make.size.equalTo(CGSize(width: 17.lpix(), height: 17.lpix()))
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(80.lpix())
        }
        bindData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FristViewCell {
    
    func bindData() {
        str.subscribe(onNext: { [weak self] str in
            if let str = str {
                self?.nameLabel.text = str
            }
        }).disposed(by: disposeBag)
    }
    
}
