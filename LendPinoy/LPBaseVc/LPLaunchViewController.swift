//
//  LPLaunchViewController.swift
//  LendPinoy
//
//  Created by 何康 on 2024/8/28.
//

import UIKit

class LPLaunchViewController: LPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        let requestManager = LPRequestManager()
        requestManager.getCode(vaguely: "", quizzical: "") { result in
            
        }
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
