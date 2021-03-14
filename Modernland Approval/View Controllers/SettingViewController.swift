//
//  SettingViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    let vm = SettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func callApiLogout(username: String) {
        let paramLogout = ["username" : username] as [String : Any]
        
        vm.postLogout(body: paramLogout, onSuccess: { response in
            UserDefaults.standard.set("", forKey: "username")
            self.goToLogin()
        }, onError: { error in
            print(error)
        }, onFailed: { failed in
            Toast.show(message: failed, controller: self)
        })
    }
    
    @IBAction func logoutButtonTap(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure to logout?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action) in
            self.callApiLogout(username: self.username ?? "")
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
