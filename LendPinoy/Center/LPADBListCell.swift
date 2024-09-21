//
//  LPADBListCell.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/9.
//

import UIKit
import RxRelay
import RxSwift

class LPADBListCell: UITableViewCell {
    
    let disposeBag = DisposeBag()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#FAFBFB")
        return bgView
    }()
    
    lazy var bblabel: UILabel = {
        let bblabel = UILabel.cjLabel(font: UIFont(name: regular_MarketFresh, size: 20)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return bblabel
    }()
    
    lazy var bbblabel: UILabel = {
        let bbblabel = UILabel.cjLabel(font: UIFont(name: bold_MarketFresh, size: 26)!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return bbblabel
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "surebtncc")
        icon.isHidden = true
        return icon
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(bblabel)
        contentView.addSubview(bbblabel)
        contentView.addSubview(icon)
        
        bblabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(22.5)
        }
        bbblabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35)
            make.top.equalTo(bblabel.snp.bottom).offset(16)
            make.height.equalTo(22.5)
            make.bottom.equalToSuperview().offset(-43.5)
        }
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-35)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        sheui()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<deliveryModel?>(value: nil)
    
}


extension LPADBListCell {
    
    func sheui() {
        model.subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.bblabel.text = model.daze ?? ""
            self.bbblabel.text = model.ours ?? ""
            if model.drank == "1" {
                self.icon.isHidden = false
                self.bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
            } else {
                self.icon.isHidden = true
                self.bgView.backgroundColor = UIColor.init(hex: "#FAFBFB")
            }
        }).disposed(by: disposeBag)
    }
    
}
