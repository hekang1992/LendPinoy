//
//  LPHomeViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/8/29.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa
import CoreLocation

class LPHomeViewController: LPBaseViewController {
    
    var vpStr = BehaviorRelay<String>(value: "1")
    
    var time: String?
    
    lazy var subView: LPSubHomeView = {
        let subView = LPSubHomeView()
        return subView
    }()
    
    lazy var manView: LPHubHomeView = {
        let manView = LPHubHomeView()
        return manView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addShuaxin()
        setupCallbacks()
    }
    
    private func setupViews() {
        [subView, manView].forEach { view.addSubview($0) }
        
        subView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        manView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hideViews()
    }
    
    private func hideViews() {
        subView.isHidden = true
        manView.isHidden = true
    }
    
    private func setupCallbacks() {
        subView.block1 = { [weak self] ppid, type in
            //judugeloaction
            guard let self = self else { return }
            let status = CLLocationManager.authorizationStatus()
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                NotificationCenter.default.post(name: NSNotification.Name(LOCATION_LP), object: nil)
                self.sqcpin(form: ppid)
            }else {
                if type == "0" {//real
                    self.showPerrt(in: self)
                }else if type == "1" {//fak
                    self.sqcpin(form: ppid)
                }else {}
            }
        }
        
        subView.block4 = { [weak self] pur in
            self?.genJuUrlPush(form: pur)
        }
        
        manView.block1 = { [weak self] pur in
            self?.genJuUrlPush(form: pur)
        }
        
        manView.block2 = { [weak self] model in
            self?.sqcpin(form: model.hesitantly ?? "")
        }
        
        manView.block3 = { [weak self] str in
            self?.vpStr.accept(str)
            if str == "2" {
                self?.huoVi()
            }else {
                self?.homeInfo()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeInfo()
    }
    
}

extension LPHomeViewController {
    
    func showPerrt(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Location Permission Required",
            message: "To continue, enable Location permissions in your Settings.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        viewController.present(alert, animated: true)
    }
    
    func huoVi() {
        let man = LPRequestManager()
        let params = ["strolled": "2", "wandering": "happy", "rip": "1"]
        man.requestAPI(params: params, pageUrl: "/lpinoy/overwhelming/important/didas", method: .get) { [weak self] result in
            switch result {
            case .success(let success):
                let model = success.itself
                self?.manView.vpType.accept(self?.vpStr.value ?? "1")
                self?.manView.homeVipModel.accept(model)
                print("model:\(model)")
                break
            case .failure(_):
                break
            }
        }
    }
    
    func homeInfo() {
        let man = LPRequestManager()
        let params = ["wandering": "product",
                      "home": "sub",
                      "strolled": SystemInfo.getCurrentTime()]
        let pageUrl = "/lpinoy/sorry/mouse/little"
        
        man.uploadDataAPI(params: params, pageUrl: pageUrl, method: .get) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.subView.scrollView.mj_header?.endRefreshing()
                self.manView.tableView.mj_header?.endRefreshing()
            }
            switch result {
            case .success(let success):
                self.handleSuccess(success.itself)
            case .failure(let error):
                print("Failed to fetch data: \(error)")
            }
        }
    }

    private func handleSuccess(_ homeModel: itselfModel) {
        if homeModel.forests?.separately == "yamada2" {
            showSubView(with: homeModel)
        } else {
            showManView(with: homeModel)
        }
    }

    private func showSubView(with homeModel: itselfModel) {
        subView.isHidden = false
        manView.isHidden = true
        subView.homeSubModel.accept(homeModel)
        subView.lunboView.reloadData()
    }

    private func showManView(with homeModel: itselfModel) {
        subView.isHidden = true
        manView.isHidden = false
        manView.homeSubModel.accept(homeModel)
        manView.lunboView.reloadData()
    }
    
    func addShuaxin() {
        subView.scrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadInfo))
        manView.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadInfo))
    }
    
    @objc func loadInfo() {
        homeInfo()
    }
    
}
