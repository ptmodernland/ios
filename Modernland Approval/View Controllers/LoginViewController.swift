//
//  LoginViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class LoginViewController: BaseViewController {

    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnEyePassword: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblUsername: UILabel!

    
    let vm = LoginViewModel()
    var deviceToken = ""
    var state = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.viewController = self
        self.hideKeyboardWhenTappedAround()
        if (self.view.frame.width == 320) {
            lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 16)
            lblUsername.font = UIFont(name: lblUsername.font.fontName, size: 14)
            lblPassword.font = UIFont(name: lblPassword.font.fontName, size: 14)
            btnLogin.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
            tfUsername.font =  UIFont.init(name: "Helvetica", size: 12.0)
            tfPassword.font =  UIFont.init(name: "Helvetica", size: 12.0)
        } else if (self.view.frame.width == 375) {
            lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 21)
            lblUsername.font = UIFont(name: lblUsername.font.fontName, size: 19)
            lblPassword.font = UIFont(name: lblPassword.font.fontName, size: 19)
            btnLogin.titleLabel?.font =  UIFont(name: "Helvetica", size: 17)
            tfUsername.font =  UIFont.init(name: "Helvetica", size: 17)
            tfPassword.font =  UIFont.init(name: "Helvetica", size: 17)
        } else if (self.view.frame.width == 414) {
            lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 24)
            lblUsername.font = UIFont(name: lblUsername.font.fontName, size: 22)
            lblPassword.font = UIFont(name: lblPassword.font.fontName, size: 22)
            btnLogin.titleLabel?.font =  UIFont(name: "Helvetica", size: 20)
            tfUsername.font =  UIFont.init(name: "Helvetica", size: 20)
            tfPassword.font =  UIFont.init(name: "Helvetica", size: 20)
        } else if (self.view.frame.width == 768) {
            lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 50)
            lblUsername.font = UIFont(name: lblUsername.font.fontName, size: 32)
            lblPassword.font = UIFont(name: lblPassword.font.fontName, size: 32)
            btnLogin.titleLabel?.font =  UIFont(name: "Helvetica", size: 32)
            tfUsername.font =  UIFont.init(name: "Helvetica", size: 28)
            tfPassword.font =  UIFont.init(name: "Helvetica", size: 28)
        } else if (self.view.frame.width == 1024) {
            lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 50)
            lblUsername.font = UIFont(name: lblUsername.font.fontName, size: 32)
            lblPassword.font = UIFont(name: lblPassword.font.fontName, size: 32)
            btnLogin.titleLabel?.font =  UIFont(name: "Helvetica", size: 32)
            tfUsername.font =  UIFont.init(name: "Helvetica", size: 28)
            tfPassword.font =  UIFont.init(name: "Helvetica", size: 28)
        }else {
            lblTitle.font = UIFont(name: lblTitle.font.fontName, size: 50)
            lblUsername.font = UIFont(name: lblUsername.font.fontName, size: 32)
            lblPassword.font = UIFont(name: lblPassword.font.fontName, size: 32)
            btnLogin.titleLabel?.font =  UIFont(name: "Helvetica", size: 32)
            tfUsername.font =  UIFont.init(name: "Helvetica", size: 28)
            tfPassword.font =  UIFont.init(name: "Helvetica", size: 28)
        }
    }
    
    /*func loadRequest(for deviceTokenString: String) {
        deviceToken = deviceTokenString
    }*/
    
    func callApiLogin(username: String, password: String, token: String) {
        showLoading()
        let deviceToken = UserDefaults().string(forKey : "fcmToken")
        let device = UIDevice.modelName
        let macAddress = UIDevice().identifierForVendor?.uuidString ?? ""
        //let ipAddress = UIDevice.current.ipAddress()
        
        let paramLogin = [
            "username" : username,
            "password" : password,
            "token" : deviceToken ?? "",
            "address" : macAddress,
            //"ip" : ipAddress ?? "",
            "ip" : self.getIPAddress(),
            "brand" : "iPhone",
            "model" : device,
            "phonetype" : "GSM"
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
        self.view.endEditing(true)
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
