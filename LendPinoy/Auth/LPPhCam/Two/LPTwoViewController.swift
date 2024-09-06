//
//  LPTwoViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/4.
//

import UIKit
import RxRelay
import RxSwift
import BRPickerView
import TYAlertController

class LPTwoViewController: LPBaseViewController {
    
    lazy var twoView: LPTwoView = {
        let twoView = LPTwoView()
        return twoView
    }()
    
    var type: String?
    
    var chanpinID: String?
    
    var itselfModel = BehaviorRelay<itselfModel?>(value: nil)
    
    var model1: ActionModel?
    
    var model2: ActionModel?
    
    var isrenlianshibie: String = "0"
    
    var kaishiTime1: String?
    
    var kaishiTime2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(twoView)
        twoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        twoView.navView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        qinqiuAInfo()
        tapClick()
    }
}

struct ActionModel {
    let title: String?
    var icon: String?
    let desc: String?
    init(title: String?, icon: String?, desc: String?) {
        self.title = title
        self.icon = icon
        self.desc = desc
    }
}

extension LPTwoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func qinqiuAInfo() {
        
        model1 = ActionModel(title: "ID Verification", icon: "Verification", desc: "Please ensure that the uploaded ID card type matches the selected ID card!")
        
        model2 = ActionModel(title: "Facial Recognition", icon: "Recognition", desc: "Please ensure good lighting, maintain a natural expression, and stay relatively still!")
        if let payment = itselfModel.value?.classical?.payment, !payment.isEmpty {
            model1?.icon = payment
        }
        if let lianurl = itselfModel.value?.payment, !lianurl.isEmpty {
            model2?.icon = lianurl
        }
        let array = [model1, model2]
        self.twoView.modelArray.accept(array)
    }
    
    func tapClick() {
        guard let model = itselfModel.value else { return }
        twoView.startblock = {
            if model.classical?.order == "0" {
                
            } else if model.classical?.order == "1" {
                
            }
        }
        
        twoView.cellClicjblock = { [weak self] index in
            if model.classical?.order == "0" {
                if index == 0 {
                    self?.popscBce()
                }else {
                    ToastUtility.showToast(message: "To better serve you, please upload your ID photo first. Thank you for your cooperation!")
                }
            } else if model.classical?.order == "1" {
                if let self = self {
                    self.kaishiTime2 = SystemInfo.getLastTime()
                    self.isrenlianshibie = "1"
                    LPPCamManager.shared.presentCamera(from: self, isFront: true)
                }
            }
        }
        
    }
    
    func popscBce() {
        let phView = PHView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: phView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        kaishiTime1 = SystemInfo.getCurrentTime()
        phView.block1 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                if let self = self {
                    self.isrenlianshibie = "0"
                    LPPCamManager.shared.presentCamera(from: self, isFront: false)
                }
            })
        }
        phView.block2 = { [weak self] in
            self?.dismiss(animated: true, completion: {
                if let self = self {
                    self.isrenlianshibie = "0"
                    LPPCamManager.shared.presentPhoto(from: self)
                }
            })
        }
        phView.block3 = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        guard let pimage = image else { return }
        let iamgeData = pimage.compressTo(maxSizeInMB: 0.8)
        picker.dismiss(animated: true) { [weak self] in
            self?.scidphoto(form: iamgeData!, image: pimage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func scidphoto(form data: Data, image: UIImage) {
        let man = LPRequestManager()
        var dict: [String: Any]?
        if self.isrenlianshibie == "0" {
            dict = ["memory": "1",
                    "reminder": chanpinID ?? "",
                    "separately": "11",
                    "big": "five",
                    "bigbang": "1",
                    "quizzical": "black",
                    "became": type ?? "",
                    "location": "1"]
        }else {
            dict = ["memory": "1",
                    "reminder": chanpinID ?? "",
                    "separately": "10",
                    "big": "six",
                    "became": type ?? "",
                    "bigbang": "2",
                    "quizzical": "black",
                    "location": "1"]
        }
        man.uploadImageAPI(params: dict,
                           pageUrl: "/lpinoy/koishi/goshu/osaka",
                           data: data,
                           method: .post) { [weak self] result in
            switch result {
            case .success(let success):
                guard let self = self else { return }
                if self.isrenlianshibie == "0" {
                    self.tanchuview(from: success.itself)
                }else {
                    self.maiInfopoint("4", self.kaishiTime2 ?? "", SystemInfo.getCurrentTime(), self.chanpinID ?? "")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        self.chanpinxiangqingyemian(self.chanpinID ?? "")
                    }
                }
                break
            case .failure(let failure):
                print("failure:\(failure)")
                break
            }
        }
    }
    
    func tanchuview(from model: itselfModel) {
        let scView = SCPopView(frame: self.view.bounds)
        scView.comoneView.nameTx.text = model.quench ?? ""
        scView.comtwoView.nameTx.text = model.attending ?? ""
        scView.comthreeView.timeBtn.setTitle(model.encouragingly ?? "", for: .normal)
        scView.comthreeView.timeBlock = { [weak self] timeBtn in
            self?.tcTimeView(from: timeBtn, scView: scView)
        }
        let alertVc = TYAlertController(alert: scView, preferredStyle: .actionSheet)
        self.present(alertVc!, animated: true)
        scView.block = { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.baocunidInfo(form: scView)
            })
        }
    }
    
    func tcTimeView(from btn: UIButton, scView: SCPopView) {
        let timeStr = btn.titleLabel?.text ?? "10-10-1900"
        let riqiArray = timeStr.components(separatedBy: "-")
        let oneStr = riqiArray[0]
        let twoStr = riqiArray[1]
        let threeStr = riqiArray[2]
        let datePickerView = BRDatePickerView()
        datePickerView.pickerMode = .YMD
        datePickerView.title = "Date"
        datePickerView.minDate = NSDate.br_setYear(1910, month: 10, day: 10)
        datePickerView.selectDate = NSDate.br_setYear(Int(threeStr)!, month: Int(twoStr)!, day: Int(oneStr)!)
        datePickerView.maxDate = Date()
        datePickerView.resultBlock = { selectDate, selectValue in
            let timeArray = selectValue!.components(separatedBy: "-")
            let year = timeArray[0]
            let mon = timeArray[1]
            let day = timeArray[2]
            scView.comthreeView.timeBtn.setTitle(String(format: "%@-%@-%@", day,mon,year), for: .normal)
        }
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = .white
        customStyle.pickerTextFont = UIFont(name: bold_MarketFresh, size: 22.lpix())
        customStyle.selectRowTextColor = UIColor.init(hex: "#2CD7BB")
        datePickerView.pickerStyle = customStyle
        datePickerView.show()
    }
    
    func baocunidInfo(form sc: SCPopView) {
        let quench = sc.comoneView.nameTx.text ?? ""
        let attending = sc.comtwoView.nameTx.text ?? ""
        let encouragingly = sc.comthreeView.timeBtn.titleLabel?.text ?? ""
        let man = LPRequestManager()
        let dict = ["quench": quench,
                    "became": type ?? "",
                    "attending": attending,
                    "promise": "pick",
                    "nike": "one",
                    "encouragingly": encouragingly,
                    "separately": "11"]
        man.requestAPI(params: dict, pageUrl: "/lpinoy/agency/deepfried/doubtful", method: .post) { [weak self] result in
            switch result {
            case .success(_):
                self?.maiInfopoint("3", self?.kaishiTime1 ?? "", SystemInfo.getCurrentTime(), self?.chanpinID ?? "")
                self?.dismiss(animated: true, completion: {
                    self?.huoquxinxiinfo(from: self?.chanpinID ?? "", completion: { baseModel in
                        if let payment = baseModel.itself.payment {
                            self?.model1?.icon = payment
                            let updatedArray = [self?.model1, self?.model2]
                            self?.twoView.modelArray.accept(updatedArray)
                        }
                    })
                })
                break
            case .failure(let failure):
                print("failure:\(failure)")
                break
            }
        }
    }
    
}

extension UIImage {
    func compressTo(maxSizeInMB: Double, compressionStep: CGFloat = 0.1) -> Data? {
        let maxSizeInBytes = maxSizeInMB * 1024 * 1024
        var compression: CGFloat = 1.0
        guard var imageData = self.jpegData(compressionQuality: compression) else { return nil }
        if imageData.count <= Int(maxSizeInBytes) {
            return imageData
        }
        while imageData.count > Int(maxSizeInBytes) && compression > 0 {
            compression -= compressionStep
            if let newImageData = self.jpegData(compressionQuality: compression) {
                imageData = newImageData
            }
        }
        return imageData
    }
}

class PHView: LPJCView {
    
    var block1: (() -> Void)?
    var block2: (() -> Void)?
    var block3: (() -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.lpix()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var phBtn: UIButton = {
        let phBtn = UIButton()
        phBtn.layer.cornerRadius = 4.lpix()
        phBtn.backgroundColor = UIColor.init(hex: "#F3FBFA")
        phBtn.setTitle("Camera", for: .normal)
        phBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .normal)
        phBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
        return phBtn
    }()
    
    lazy var camBtn: UIButton = {
        let camBtn = UIButton()
        camBtn.layer.cornerRadius = 4.lpix()
        camBtn.backgroundColor = UIColor.init(hex: "#F3FBFA")
        camBtn.setTitle("Photo Album", for: .normal)
        camBtn.setTitleColor(UIColor.init(hex: "#303434"), for: .normal)
        camBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
        return camBtn
    }()
    
    lazy var xiaoshiBtn: UIButton = {
        let xiaoshiBtn = UIButton()
        xiaoshiBtn.layer.cornerRadius = 4.lpix()
        xiaoshiBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        xiaoshiBtn.setTitle("Cancel", for: .normal)
        xiaoshiBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        xiaoshiBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
        return xiaoshiBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(phBtn)
        bgView.addSubview(camBtn)
        bgView.addSubview(xiaoshiBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.lpix(), height: 300.lpix()))
        }
        phBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalToSuperview().offset(20.lpix())
            make.height.equalTo(80.lpix())
        }
        camBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(phBtn.snp.bottom).offset(20.lpix())
            make.height.equalTo(80.lpix())
        }
        xiaoshiBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(camBtn.snp.bottom).offset(20.lpix())
            make.height.equalTo(60.lpix())
        }
        
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PHView {
    
    func tapClick() {
        phBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block1?()
        }).disposed(by: disposeBag)
        
        camBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        
        xiaoshiBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block3?()
        }).disposed(by: disposeBag)
    }
    
}

class SCPopView: UIView {
    
    var block: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(hex: "#FFFFFF")
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.lpix()
        return bgView
    }()
    
    lazy var biaotiLabel: UILabel = {
        let biaotiLabel = UILabel.buildLabel(font: UIFont(name: bold_MarketFresh, size: 22.lpix())!, textColor: UIColor.init(hex: "#303434"), textAlignment: .left)
        biaotiLabel.text = "Confirm ID information."
        return biaotiLabel
    }()
    
    lazy var mLabel: UILabel = {
        let mLabel = UILabel.buildLabel(font: UIFont(name: regular_MarketFresh, size: 14.lpix())!, textColor: UIColor.init(hex: "#D2D3D7"), textAlignment: .left)
        mLabel.numberOfLines = 0
        mLabel.text = "Please verify your ID information to prevent review failure."
        return mLabel
    }()
    
    lazy var comoneView: LPCommonView = {
        let comoneView = LPCommonView(frame: .zero, typeEnum: .normal)
        comoneView.nameLabel.text = "Name"
        return comoneView
    }()
    
    lazy var comtwoView: LPCommonView = {
        let comtwoView = LPCommonView(frame: .zero, typeEnum: .normal)
        comtwoView.nameLabel.text = "ID Number"
        return comtwoView
    }()
    
    lazy var comthreeView: LPCommonView = {
        let comthreeView = LPCommonView(frame: .zero, typeEnum: .click)
        comthreeView.nameLabel.text = "Date"
        return comthreeView
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton()
        sureBtn.layer.cornerRadius = 4.lpix()
        sureBtn.backgroundColor = UIColor.init(hex: "#2CD7BB")
        sureBtn.setTitle("Save", for: .normal)
        sureBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        sureBtn.titleLabel?.font = UIFont(name: bold_MarketFresh, size: 22.lpix())
        return sureBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(scrollView)
        scrollView.addSubview(biaotiLabel)
        scrollView.addSubview(mLabel)
        scrollView.addSubview(comoneView)
        scrollView.addSubview(comtwoView)
        scrollView.addSubview(comthreeView)
        scrollView.addSubview(sureBtn)
        makess()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makess() {
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 335.lpix(), height: 558.lpix()))
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        biaotiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(26.lpix())
        }
        mLabel.snp.makeConstraints { make in
            make.top.equalTo(biaotiLabel.snp.bottom).offset(10.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.centerX.equalToSuperview()
        }
        comoneView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(mLabel.snp.bottom).offset(20.lpix())
            make.height.equalTo(98.lpix())
        }
        comtwoView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(comoneView.snp.bottom).offset(20.lpix())
            make.height.equalTo(98.lpix())
        }
        comthreeView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(comtwoView.snp.bottom).offset(20.lpix())
            make.height.equalTo(98.lpix())
        }
        sureBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(comthreeView.snp.bottom).offset(40.lpix())
            make.left.equalToSuperview().offset(20.lpix())
            make.height.equalTo(60.lpix())
            make.bottom.equalToSuperview().offset(-30.lpix())
        }
        
        sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disposeBag)
    }
    
}
