//
//  PATabBar.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import UIKit
import RxSwift
import RxCocoa

class LPTabBar: UIView {
    
    var block: ((_ tabBar: LPTabBar, _ from: Int, _ to: Int) -> Void)?
    
    private var selectedButton: LPBarButton?
    
    private var tabbarBtnArray: [LPBarButton] = []
    
    private var norImageArr: [String] = []
    
    private var selImageArr: [String] = []
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hex: "#F3FBFA")
        bgView.layer.cornerRadius = 27
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension LPTabBar {
    
    func addTabBarButtonNorImageUrl(_ norImageUrl: String, selImageUrl: String, title: String) {
        let tabBarBtn = LPBarButton()
        tabBarBtn.block = { [weak self] btn in
            self?.buttonClick(btn)
        }
        addSubview(tabBarBtn)
        tabBarBtn.setTabBarImage(url: norImageUrl, title: title)
        tabBarBtn.addTarget(self, action: #selector(buttonClick(_:)), for: .touchDown)
        tabbarBtnArray.append(tabBarBtn)
        norImageArr.append(norImageUrl)
        selImageArr.append(selImageUrl)
        if tabbarBtnArray.count == 1 {
            buttonClick(tabBarBtn)
            tabBarBtn.iconBtn.isSelected = true
        }
    }
    
    func ybButton(_ ybButton: LPBarButton) {
        for (index, cButton) in tabbarBtnArray.enumerated() {
            if cButton == ybButton {
                cButton.iconBtn.isSelected = true
                cButton.iconBtn.setBackgroundImage(UIImage(named: selImageArr[index]), for: .normal)
            } else {
                cButton.iconBtn.isSelected = false
                cButton.iconBtn.setBackgroundImage(UIImage(named: norImageArr[index]), for: .normal)
            }
        }
    }
    
    @objc private func buttonClick(_ button: LPBarButton) {
        if let fromIndex = selectedButton?.tag {
            self.block?(self, fromIndex, button.tag)
        }
        selectedButton?.isSelected = false
        button.isSelected = true
        selectedButton = button
        ybButton(selectedButton!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonW = frame.width / CGFloat(tabbarBtnArray.count)
        let buttonY = 1
        for (index, button) in tabbarBtnArray.enumerated() {
            let buttonX = CGFloat(index) * buttonW
            button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: 50)
            button.tag = index
        }
    }
}
