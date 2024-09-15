//
//  LPOrderListCell.swift
//  LendPinoy
//
//  Created by 何康 on 2024/9/10.
//

import UIKit
import RxRelay
import RxSwift

class LPOrderListCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    var tapBlock: ((UIButton) -> Void)?
    
    var tapoBlock: ((String) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.lpix()
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        return bgView
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.init(hex: "#2CD7BB")
        icon.layer.cornerRadius = 4.lpix()
        icon.layer.masksToBounds = true
        return icon
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 20.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var label1: UILabel = {
        let label1 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 18.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return label1
    }()
    
    lazy var label2: UILabel = {
        let label2 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 18.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        return label2
    }()
    
    lazy var label3: UILabel = {
        let label3 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 14.lpix())!, textColor: UIColor.init(hex: "#CFD9D8"), textAlignment: .left)
        label3.numberOfLines = 0
        return label3
    }()
    
    lazy var label4: UILabel = {
        let label4 = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 14.lpix())!, textColor: UIColor.init(hex: "#CFD9D8"), textAlignment: .left)
        return label4
    }()
    
    lazy var reBtn: UIButton = {
        let reBtn = UIButton(type: .custom)
        reBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 17.lpix())
        reBtn.setTitle("Repay", for: .normal)
        reBtn.layer.cornerRadius = 4.lpix()
        reBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        reBtn.setTitleColor(.white, for: .normal)
        return reBtn
    }()
    
    lazy var ooLabel: UILabel = {
        let ooLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 12.lpix())!, textColor: .white, textAlignment: .center)
        ooLabel.backgroundColor = UIColor.init(hex: "#FF335B")
        ooLabel.layer.cornerRadius = 4.lpix()
        ooLabel.layer.masksToBounds = true
        return ooLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(icon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        contentView.addSubview(label4)
        contentView.addSubview(ooLabel)
        contentView.addSubview(reBtn)
        makess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model = BehaviorRelay<dazedModel?>(value: nil)
    
}

extension LPOrderListCell {
    
    func makess() {
        icon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.lpix())
            make.left.equalToSuperview().offset(35.lpix())
            make.size.equalTo(CGSize(width: 25.lpix(), height: 25.lpix()))
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(15.lpix())
            make.centerY.equalTo(icon.snp.centerY)
            make.height.equalTo(22.5.lpix())
        }
        label1.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(15.lpix())
            make.left.equalTo(icon.snp.left)
            make.height.equalTo(20.lpix())
        }
        label2.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(15.lpix())
            make.left.equalTo(label1.snp.right).offset(42.lpix())
            make.height.equalTo(20.lpix())
        }
        label3.snp.makeConstraints { make in
            make.top.equalTo(label1.snp.bottom).offset(3.5.lpix())
            make.left.equalTo(icon.snp.left)
            make.width.equalTo(75.lpix())
        }
        label4.snp.makeConstraints { make in
            make.top.equalTo(label2.snp.bottom).offset(3.5.lpix())
            make.left.equalTo(label2.snp.left)
            make.height.equalTo(15.lpix())
            make.bottom.equalToSuperview().offset(-35.5.lpix())
        }
        reBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20.lpix())
            make.right.equalToSuperview().offset(-35.5.lpix())
            make.size.equalTo(CGSize(width: 85.lpix(), height: 40.lpix()))
        }
        ooLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20.lpix())
            make.height.equalTo(CGSize(width: 145.lpix(), height: 25.lpix()))
        }
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.lpix())
        }
        
        reBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.tapoBlock?(self?.model.value?.precisely ?? "")
        }).disposed(by: disposeBag)
        
        model.subscribe(onNext: { [weak self] model1 in
            guard let self = self, let model1 = model1 else { return }
            if let shrines = model1.shrines {
                self.nameLabel.text = shrines
            }
            self.icon.kf.setImage(with: URL(string: model1.endless ?? ""))
            self.label1.text = model1.insist ?? ""
            self.label2.text = model1.strangest ?? ""
            self.label3.text = model1.suffers ?? ""
            self.label4.text = model1.loanText ?? ""
            if let mess = model1.mess, !mess.isEmpty, mess != "0" {
                self.ooLabel.text = "Overdue by \(model1.mess ?? "") days!"
            }
        }).disposed(by: disposeBag)
    }
    
}


class WSView: LPJCView {
    
    var block: (() -> Void)?
    
    lazy var wicon: UIImageView = {
        let wicon = UIImageView()
        wicon.image = UIImage(named: "nnodaqd")
        return wicon
    }()
    
    lazy var bgView1: UIView = {
        let bgView1 = UIView()
        bgView1.backgroundColor = UIColor.init(hex: "#F3FBFA")
        bgView1.layer.cornerRadius = 4.lpix()
        return bgView1
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "dunpaiopp")
        return icon
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 12.lpix())!, textColor: UIColor.init(hex: "#2CD7BB"), textAlignment: .left)
        descLabel.text = "We will provide comprehensive protection for your privacy data."
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var takeBtn: UIButton = {
        let takeBtn = UIButton(type: .custom)
        takeBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 20.lpix())
        takeBtn.setTitle("Take out a loan", for: .normal)
        takeBtn.setTitleColor(UIColor.white, for: .normal)
        takeBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        takeBtn.layer.cornerRadius = 4.lpix()
        return takeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(wicon)
        addSubview(bgView1)
        addSubview(takeBtn)
        bgView1.addSubview(icon)
        bgView1.addSubview(descLabel)
        wicon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100.lpix())
            make.size.equalTo(CGSize(width: 275.lpix(), height: 192.lpix()))
        }
        takeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.lpix(), height: 60.lpix()))
            make.bottom.equalToSuperview().offset(-40.lpix())
        }
        bgView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(takeBtn.snp.bottom).offset(-10.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(35.lpix())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.lpix())
            make.size.equalTo(CGSize(width: 14.lpix(), height: 18.lpix()))
        }
        descLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15.lpix())
            make.left.equalTo(icon.snp.right).offset(10.lpix())
        }
        
        takeBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
