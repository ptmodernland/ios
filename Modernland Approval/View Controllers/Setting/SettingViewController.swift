//
//  SettingViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgGender: UIImageView!
    
    let vm = SettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblName.text = UserDefaults().string(forKey: "name")
        lblEmail.text = UserDefaults().string(forKey: "email")
        if UserDefaults().string(forKey: "gender") == "P" {
            imgGender.image = UIImage(named: "imgFemale")
        }
    }
    
    func callApiLogout(username: String) {
        self.showLoading()
        let paramLogout = ["username" : username] as [String : Any]
        
        vm.postLogout(body: paramLogout, onSuccess: { response in
            self.hideLoading()
            UserDefaults.standard.set("", forKey: "username")
            UserDefaults.standard.set("", forKey: "idUser")
            UserDefaults.standard.set("", forKey: "level")
            UserDefaults.standard.set("", forKey: "name")
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "gender")
            self.goToLogin()
        }, onError: { error in
            self.hideLoading()
            print(error)
        }, onFailed: { failed in
            self.hideLoading()
            Toast.show(message: failed, controller: self)
        })
    }
    
    @IBAction func changePasswordButtonTap(_ sender: Any) {
        let vc = StoryboardScene.Setting.changePasswordViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
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
