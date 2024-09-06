//
//  LPCycleView.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/2.
//

import UIKit
import Lottie

class LPCycleView: LPJCView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return bgView
    }()
    
    lazy var hudView: LottieAnimationView = {
        let hudView = LottieAnimationView(name: "recyle.json", bundle: Bundle.main)
        hudView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        hudView.layer.cornerRadius = 4.lpix()
        hudView.loopMode = .loop
        hudView.play()
        return hudView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(bgView)
        bgView.addSubview(hudView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hudView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 120.lpix(), height: 120.lpix()))
        }
    }
}


class ViewCycleManager {
    
    static let loadView = LPCycleView()
    
    static func addCycView() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                DispatchQueue.main.async {
                    loadView.frame = keyWindow.bounds
                    keyWindow.addSubview(loadView)
                }
            }
        }
    }
    
    static func hideCycView() {
        DispatchQueue.main.async {
            loadView.removeFromSuperview()
        }
    }
    
}
