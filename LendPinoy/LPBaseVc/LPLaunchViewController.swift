//
//  LPLaunchViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import UIKit
import Alamofire

class LPLaunchViewController: LPBaseViewController {
    
    lazy var gbImageView: UIImageView = {
        let gbImageView = UIImageView()
        gbImageView.contentMode = .scaleAspectFill
        gbImageView.image = UIImage(named: "launchima")
        return gbImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(gbImageView)
        gbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        isopenWangluo()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LPLaunchViewController {
    
    func isopenWangluo() {
        NetworkReachability.shared.startListening()
        NetworkReachability.shared.networkStatusChanged = { netType in
            print("网络状态已改变: \(netType)")
        }
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
            case .reachable(.cellular):
                self?.netType = "4g/5g"
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
