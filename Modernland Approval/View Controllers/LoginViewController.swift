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
    @IBOutlet weak var btnEyePassword: UIButton!
    
    let vm = LoginViewModel()
    var deviceToken = ""
    var state = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
    }
    
    func loadRequest(for deviceTokenString: String) {
        deviceToken = deviceTokenString
    }
    
    func callApiLogin(username: String, password: String, token: String) {
        showLoading()
        let device = UIDevice.modelName
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        //let ipAddress = UIDevice.current.ipAddress()
        
        let paramLogin = [
            "username" : username,
            "password" : password,
            "token" : "f7KLo4kLxGI:APA91bFrYRlaR61n3gjtTv9bBd-W5zE3P1Ma_Rs9Ql3ROZY3m7BUWy6S7dm-KSNjIEBu4GYJU3vPt-E6v4dP2_hwq_MLr_HQRYijou3utRJqDgFzNFSjcxoar23SFD0AWNJGl1xYGAzR",
            "address" : macAddress,
            //"ip" : ipAddress ?? "",
            "ip" : self.getIPAddress(),
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
    
    @IBAction func btnEyeTap(_ sender: Any) {
        if state == true {
            tfPassword.isSecureTextEntry = false
            tfPassword.togglePasswordVisibility()
            if #available(iOS 13.0, *) {
                btnEyePassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }
        } else {
            tfPassword.isSecureTextEntry = true
            tfPassword.togglePasswordVisibility()
            if #available(iOS 13.0, *) {
                btnEyePassword.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }
        state = !state
    }
    
    
    @IBAction func loginButtonTap(_ sender: Any) {
        let stringUsername = tfUsername.text ?? ""
        let stringPassword = tfPassword.text ?? ""
        callApiLogin(username: stringUsername, password: stringPassword, token: "")
    }
}
