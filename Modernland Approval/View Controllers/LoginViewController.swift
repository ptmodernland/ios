//
//  LoginViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!

    @IBOutlet weak var btnVisible: UIButton!
    
    
    let vm = LoginViewModel()
    var deviceToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
    }
    
    @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
            (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
            if (sender as! UIButton).isSelected {
                self.tfPassword.isSecureTextEntry = false
                self.btnVisible.setImage(UIImage(named: "eye_open.png"), for: .normal)
            } else {
                self.tfPassword.isSecureTextEntry = true
                self.btnVisible.setImage(UIImage(named: "eye_close.png"), for: .normal)
            }
        }

    
    func loadRequest(for deviceTokenString: String) {
        deviceToken = deviceTokenString
    }
    
    func callApiLogin(username: String, password: String, token: String) {
        showLoading()
        let device = UIDevice.modelName
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        let ipAddress = UIDevice.current.ipAddress()
        
        let paramLogin = [
            "username" : username,
            "password" : password,
            "token" : "f7KLo4kLxGI:APA91bFrYRlaR61n3gjtTv9bBd-W5zE3P1Ma_Rs9Ql3ROZY3m7BUWy6S7dm-KSNjIEBu4GYJU3vPt-E6v4dP2_hwq_MLr_HQRYijou3utRJqDgFzNFSjcxoar23SFD0AWNJGl1xYGAzR",
            "address" : macAddress,
            "ip" : ipAddress ?? "",
            "brand" : "iPhone",
            "model" : device,
            "phonetype" : "gsm"
        ] as [String : Any]
        
        vm.postLogin(body: paramLogin, onSuccess: { response in
            self.hideLoading()
            let defaults = UserDefaults.standard
            print(response.username ?? "")
            defaults.set(response.username, forKey: "username")
            defaults.set(response.idUser, forKey: "idUser")
            defaults.set(response.level, forKey: "level")
            defaults.set(response.name, forKey: "name")
            defaults.set(response.email, forKey: "email")
            defaults.set(response.gender, forKey: "gender")
            self.goToHome()
        }, onError: { error in
            self.hideLoading()
            Toast.show(message: "Terjadi Kesalahan", controller: self)
        }, onFailed: { failed in
            self.hideLoading()
            Toast.show(message: failed, controller: self)
        })
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        let stringUsername = tfUsername.text ?? ""
        let stringPassword = tfPassword.text ?? ""
        callApiLogin(username: stringUsername, password: stringPassword, token: "")
    }
}
