//
//  LPBaseViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/8/28.
//

import UIKit
import RxSwift
import SwiftUI

class LPBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var ninett: String?
    
    lazy var navView: LPNavgationView = {
        let navView = LPNavgationView()
        return navView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    
}

extension LPBaseViewController {
    
    func addNavView(title: String) {
        view.addSubview(navView)
        navView.titleLabel.text = title
        navView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
    }
    
    func sqcpin(form proid: String) {
        let dict = ["therapy": "2024",
                    "reminder": proid,
                    "session": "0",
                    "think": "description"]
        let man = LPRequestManager()
        man.requestAPI(params: dict,
                       pageUrl: "/lpinoy/tablename/thoughts/kyotoites",
                       method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                if let payment = success.itself.payment {
                    self?.genJuUrlPush(form: payment)
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func genJuUrlPush(form payment: String) {
        guard let url = URL(string: payment),
              let scheme = url.scheme else { return }
        switch scheme {
        case let s where s.hasPrefix("http"):
            handleHTTPUrl(payment: payment)
        case let s where s.hasPrefix("pinoy"):
            handlePinoyUrl(url: url, payment: payment)
        default:
            break
        }
    }
    
    private func handleHTTPUrl(payment: String) {
        self.pushToWebVc(form: payment)
    }
    
    private func handlePinoyUrl(url: URL, payment: String) {
        let path = url.path
        if path.contains("/disappeared") {
            ViewCycleManager.addCycView()
            handleDisappearedPath(query: url.query)
        } else if path.contains("/expectations") {
            handleExpectationsPath(payment: payment)
        } else if path.contains("/opposite") {
            handleOppositePath(payment: payment)
        } else if path.contains("/imagine") {
            NotificationCenter.default.post(name: NSNotification.Name(ROOT_VC_NOTI), object: nil, userInfo: ["guest": "0"])
        }
    }
    
    private func handleDisappearedPath(query: String?) {
        guard let query = query else { return }
        let components = query.components(separatedBy: "=")
        let chanpinid = components.last ?? ""
        chanpinxiangqingyemian(chanpinid)
    }
    
    private func handleExpectationsPath(payment: String) {
        guard let productID = extractParameter(from: payment, name: "reminder"),
              let orderID = extractParameter(from: payment, name: "embarrassment") else { return }
        
        let bVc = LPADBListViewController()
        bVc.reminder.accept(productID)
        bVc.embarrassment.accept(orderID)
        self.navigationController?.pushViewController(bVc, animated: true)
    }
    
    private func handleOppositePath(payment: String) {
        let ovc = LPOrderListViewController()
        if let value = extractParameter(from: payment, name: "supposed") {
            ovc.li.accept(value)
            self.navigationController?.pushViewController(ovc, animated: true)
        }
    }
    
    private func extractParameter(from payment: String, name: String) -> String? {
        guard let range = payment.range(of: "\(name)=") else { return nil }
        let value = payment[range.upperBound...]
        if let endRange = value.range(of: "&") {
            return String(value[..<endRange.lowerBound])
        }
        return String(value)
    }
    
    func chanpinxiangqingyemian(_ chanpinid: String) {
        let dict = ["improper": "Andrew", "reminder": chanpinid, "unsure": "toal"]
        let man = LPRequestManager()
        man.requestAPI(params: dict, pageUrl: "/lpinoy/scanned/thinking/chieko", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                if let page = success.itself.researching?.exchanged, !page.isEmpty {
                    self?.pushYeMian(page, chanpinid)
                } else {
                    if let shocking = success.itself.admit?.shocking {
                        self?.ninett = SystemInfo.getCurrentTime()
                        self?.gjOdtoUrl(from: shocking, ppid: chanpinid)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func pushYeMian(_ page: String, _ chanpinid: String) {
        if page == "shooing1" {
            self.huoquxinxiinfo(from: chanpinid) { [weak self] baseModel in
                if let self = self,
                   let pap = baseModel.itself.classical?.payment {
                    if !pap.isEmpty {
                        let twoVc = LPTwoViewController()
                        twoVc.chanpinID = chanpinid
                        twoVc.itselfModel.accept(baseModel.itself)
                        self.navigationController?.pushViewController(twoVc, animated: true)
                    }else {
                        let oneVc = FristVcViewController()
                        oneVc.chanpinid.accept(chanpinid)
                        self.navigationController?.pushViewController(oneVc, animated: true)
                    }
                }
            }
            
        } else if page == "shooing2" {
            let samVc = SamViewController()
            samVc.chanpinID.accept(chanpinid)
            self.navigationController?.pushViewController(samVc, animated: true)
        } else if page == "shooing3" {
            let siVc = SIViewController()
            siVc.chanpinID.accept(chanpinid)
            self.navigationController?.pushViewController(siVc, animated: true)
        } else if page == "shooing4" {
            let wuVc = WUViewController()
            wuVc.chanpinID.accept(chanpinid)
            self.navigationController?.pushViewController(wuVc, animated: true)
        } else if page == "shooing5" {
            let sixVc = LIUViewController()
            sixVc.chanpinID.accept(chanpinid)
            self.navigationController?.pushViewController(sixVc, animated: true)
        } else {}
    }
    
    func gjOdtoUrl(from oid: String, ppid: String) {
        let dict = ["nodaiwa": "1", "subject": "math", "thorough": oid, "changing": "m9", "decided": "bbc"]
        let man = LPRequestManager()
        man.requestAPI(params: dict, pageUrl: "/lpinoy/flavourwas/agency/workingrestaurant", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                if let payment = success.itself.payment {
                    self.maiInfopoint("9", self.ninett ?? "", SystemInfo.getCurrentTime(), ppid)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.pushToWebVc(form: payment)
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func maiInfopoint(_ point: String, _ time: String, _ endtime: String, _ chanpinID: String) {
        let location = LPDingWeiManager()
        location.startUpdatingLocation { locationModel in
            let manager = LPRequestManager()
            let pointDict = [
                "mizuo": DeviceInfo.getIDFA(),
                "cupping": point,
                "heike": chanpinID,
                "tea": "greenTea",
                "adds": KeychainHelper.retrieveidfv() ?? "",
                "lemon": "tree",
                "shichimi": locationModel.shichimi,
                "spice": locationModel.spice,
                "village": time,
                "arm": endtime,
                "tucking": "mins"] as [String : Any]
            manager.uploadDataAPI(params: pointDict,
                                  pageUrl: "/lpinoy/chieko/thats/dripping",
                                  method: .post) { result in
                
            }
        }
    }
    
    func huoquxinxiinfo(from chanpinid: String, completion: @escaping (BaseModel) -> Void) {
        let dict = ["reminder": chanpinid, "tale": "5", "have": "1"]
        let man = LPRequestManager()
        man.requestAPI(params: dict,
                       pageUrl: "/lpinoy/wouldnt/outstanding/early",
                       method: .get) { result in
            switch result {
            case .success(let success):
                completion(success)
                break
            case .failure(_):
                break
            }
        }
    }
    
    func pushToWebVc(form url: String) {
        let webVc = LPHFViewController()
        let requstUrl = RePinJieURL.appendQueryParameters(urlString: url, parameters: LPLoginInfo.getLogiInfo())
        webVc.lianjie.accept(requstUrl ?? "")
        self.navigationController?.pushViewController(webVc, animated: true)
    }
    
}
