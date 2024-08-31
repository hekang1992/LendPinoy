//
//  LPLaunchViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import UIKit
import Alamofire

let ROOT_VC_NOTI = "ROOT_VC_NOTI"

class LPLaunchViewController: LPBaseViewController {
    
    lazy var gbImageView: UIImageView = {
        let gbImageView = UIImageView()
        gbImageView.contentMode = .scaleAspectFill
        gbImageView.image = UIImage(named: "launchima")
        gbImageView.isUserInteractionEnabled = true
        return gbImageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18.lpix())
        loginBtn.setTitleColor(UIColor.init(hex: "#2CD7BB"), for: .normal)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.layer.cornerRadius = 4.lpix()
        loginBtn.backgroundColor = .white
        return loginBtn
    }()
    
    lazy var youkeBtn: UIButton = {
        let youkeBtn = UIButton(type: .custom)
        youkeBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 18.lpix())
        youkeBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        youkeBtn.setTitle("Log in as a guest", for: .normal)
        youkeBtn.layer.cornerRadius = 4.lpix()
        youkeBtn.backgroundColor = .clear
        youkeBtn.layer.borderWidth = 3.lpix()
        youkeBtn.layer.borderColor = UIColor.init(hex: "#FFFFFF").cgColor
        return youkeBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gbImageView)
        gbImageView.addSubview(scrollView)
        scrollView.addSubview(loginBtn)
        scrollView.addSubview(youkeBtn)
        gbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalToSuperview().offset(435.lpix())
            make.height.equalTo(60.lpix())
        }
        youkeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(loginBtn.snp.bottom).offset(30.lpix())
            make.height.equalTo(60.lpix())
            make.bottom.equalToSuperview().offset(-50.lpix())
        }
        isopenWangluo()
        tap()
    }
    
}

extension LPLaunchViewController {
    
    func isopenWangluo() {
        NetworkReachability.shared.startListening()
        NetworkReachability.shared.networkStatusChanged = { netType in
            print("netType======\(netType)")
        }
    }
    
    func tap() {
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.postNoti()
        }).disposed(by: disposeBag)
        
        youkeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.postNoti()
        }).disposed(by: disposeBag)
    }
    
    func postNoti() {
        NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil)
    }
    
}

class NetworkReachability {
    
    var netType: String?
    var networkStatusChanged: ((String) -> Void)?
    
    static let shared = NetworkReachability()
    private let reachabilityManager = NetworkReachabilityManager()
    
    private init() {}
    
    func startListening() {
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            switch status {
            case .notReachable:
                self?.netType = "none"
            case .reachable(.ethernetOrWiFi):
                self?.netType = "wifi"
                self?.stopListening()
            case .reachable(.cellular):
                self?.netType = "4g/5g"
                self?.stopListening()
            case .unknown:
                self?.netType = "none"
            }
            self?.networkStatusChanged?(self?.netType ?? "")
        })
    }
    
    func stopListening() {
        reachabilityManager?.stopListening()
    }
    
    func isReachable() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
}
