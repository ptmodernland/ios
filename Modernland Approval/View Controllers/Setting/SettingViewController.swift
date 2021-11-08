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
    @IBOutlet weak var lblTxtSetting: UILabel!
    @IBOutlet weak var imageConstrain1: NSLayoutConstraint!
    @IBOutlet weak var imageConstrain2: NSLayoutConstraint!
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet var settingView: UIView!
    
    let vm = SettingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.view.frame.width == 320) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 12)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 12)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 14)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
            self.imageConstrain1.constant = 150
            self.imageConstrain2.constant = 150
            self.settingView.layoutIfNeeded()
        } else if (self.view.frame.width == 375) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 14)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 14)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 16)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.imageConstrain1.constant = 150
            self.imageConstrain2.constant = 150
            self.settingView.layoutIfNeeded()
        } else if (self.view.frame.width == 390) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 14)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 14)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 16)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            self.imageConstrain1.constant = 150
            self.imageConstrain2.constant = 150
            self.settingView.layoutIfNeeded()
        }  else if (self.view.frame.width == 414) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 16)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 16)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 20)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.imageConstrain1.constant = 150
            self.imageConstrain2.constant = 150
            self.settingView.layoutIfNeeded()
        } else if (self.view.frame.width == 428) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 16)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 16)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 20)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
            self.imageConstrain1.constant = 150
            self.imageConstrain2.constant = 150
            self.settingView.layoutIfNeeded()
        }  else if (self.view.frame.width == 768) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 32)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 32)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 45)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 32)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 32)
            self.imageConstrain1.constant = 270
            self.imageConstrain2.constant = 270
            self.settingView.layoutIfNeeded()
        } else if (self.view.frame.width == 1024) {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 45)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 45)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 50)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 45)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 45)
            self.imageConstrain1.constant = 240
            self.imageConstrain2.constant = 240
            self.settingView.layoutIfNeeded()
        } else {
            self.lblName.font = UIFont(name: self.lblName.font.fontName, size: 45)
            self.lblEmail.font = UIFont(name: self.lblEmail.font.fontName, size: 45)
            self.lblTxtSetting.font = UIFont.boldSystemFont(ofSize: 50)
            self.btnChangePassword.titleLabel?.font =  UIFont(name: "Helvetica", size: 45)
            self.btnLogout.titleLabel?.font =  UIFont(name: "Helvetica", size: 45)
            self.imageConstrain1.constant = 270
            self.imageConstrain2.constant = 270
            self.settingView.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblName.text = UserDefaults().string(forKey: "name")
        lblEmail.text = UserDefaults().string(forKey: "email")
        if UserDefaults().string(forKey: "gender") == "P" {
            imgGender.image = UIImage(named: "imgFemale")
        }
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func callApiLogout(username: String) {
        self.showLoading()
        let paramLogout = ["username" : username] as [String : Any]
        
        vm.postLogout(body: paramLogout, onSuccess: { response in
            self.hideLoading()
            UserDefaults.standard.set("", forKey: "username")
            //UserDefaults.standard.set("", forKey: "fcmToken")
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
