//
//  LPAgreeViewController.swift
//  LendPinoy
//
//  Created by Banana on 2024/9/1.
//

import UIKit

class LPAgreeViewController: LPBaseViewController {
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.adjustsImageWhenHighlighted = false
        btn1.setImage(UIImage(named: "daikuanpin"), for: .normal)
        return btn1
    }()
    
    lazy var btn2: UIButton = {
        let btn2 = UIButton(type: .custom)
        btn2.adjustsImageWhenHighlighted = false
        btn2.setImage(UIImage(named: "yinsidianji"), for: .normal)
        return btn2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addNavView(title: "Agreement")
        view.addSubview(btn1)
        view.addSubview(btn2)
        makesnpView()
        tap()
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

extension LPAgreeViewController {
    
    func makesnpView() {
        btn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(navView.snp.bottom).offset(20.lpix())
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
        }
        btn2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.lpix())
            make.top.equalTo(btn1.snp.bottom).offset(20.lpix())
            make.centerX.equalToSuperview()
            make.height.equalTo(80.lpix())
        }
    }
    
    func tap() {
        self.navView.block = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        btn1.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            ToastUtility.showToast(message: "贷款协议")
        }).disposed(by: disposeBag)
        
        btn2.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            ToastUtility.showToast(message: "隐私协议")
        }).disposed(by: disposeBag)
    }
    
}
