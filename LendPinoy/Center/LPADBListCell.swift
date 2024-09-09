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
        let bblabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 20.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return bblabel
    }()
    
    lazy var bbblabel: UILabel = {
        let bbblabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 26.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
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
            make.left.equalToSuperview().offset(35.lpix())
            make.top.equalToSuperview().offset(15.lpix())
            make.height.equalTo(22.5.lpix())
        }
        bbblabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.lpix())
            make.top.equalTo(bblabel.snp.bottom).offset(16.lpix())
            make.height.equalTo(22.5.lpix())
            make.bottom.equalToSuperview().offset(-43.5.lpix())
        }
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.lpix())
            make.left.equalToSuperview().offset(20.lpix())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-35.lpix())
            make.size.equalTo(CGSize(width: 25.lpix(), height: 25.lpix()))
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
