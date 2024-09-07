//
//  LPBaseViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/28.
//

import UIKit
import RxSwift
import SwiftUI

class LPBaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
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
            make.top.equalToSuperview().offset(StatusManager.statusBarHeight + 5.lpix())
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44.lpix())
        }
    }
    
    func shenqingchanpin(form proid: String) {
        let dict = ["therapy": "2024", "reminder": proid, "session": "0"]
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
        guard let url = URL(string: payment), let sch = url.scheme else { return }
        if sch.hasPrefix("http")  {
            let hfView = LPHFViewController()
            hfView.lianjie.accept(payment)
            self.navigationController?.pushViewController(hfView, animated: true)
        } else if sch.hasPrefix("pinoy") {
            let path = url.path
            if path.contains("/disappeared") {
                guard let query = url.query else { return }
                let arr = query.components(separatedBy: "=")
                let chanpinid = arr.last ?? ""
                chanpinxiangqingyemian(chanpinid)
            }
        } else {
            
        }
    }
    
    func chanpinxiangqingyemian(_ chanpinid: String) {
        let dict = ["improper": "banana", "reminder": chanpinid, "unsure": "toal"]
        let man = LPRequestManager()
        man.requestAPI(params: dict, pageUrl: "/lpinoy/scanned/thinking/chieko", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                if let page = success.itself.researching?.exchanged {
                    self?.pushYeMian(page, chanpinid)
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
    
    func maiInfopoint(_ point: String, _ time: String, _ endtime: String, _ chanpinID: String) {
        let location = LPDingWeiManager()
        location.startUpdatingLocation { locationModel in
            let manager = LPRequestManager()
            let pointDict = [
                "mizuo": DeviceInfo.getIDFA(),
                "cupping": point,
                "heike": chanpinID,
                "tea": "greenTea",
                "adds": KeychainHelper.retrieveIDFVFromKeychain() ?? "",
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
    
}
