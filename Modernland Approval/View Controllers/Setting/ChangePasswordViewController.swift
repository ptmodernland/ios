//
//  ChangePasswordViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 25/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfNewPin: UITextField!
    
    @IBOutlet weak var lblChangePassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    
    @IBOutlet weak var lblNewPin: UILabel!
    @IBOutlet weak var btnEyeNewPassword: UIButton!
    @IBOutlet weak var btnEyeConfirmPassword: UIButton!
    @IBOutlet weak var btnEyeNewPin: UIButton!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var hideNewPassword = true
    var hideConfirmPassword = true
    var hideNewPin = true
    
    let vm = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNewPin.keyboardType = .numberPad
        tfNewPin.delegate = self
        btnBack.layer.cornerRadius = 6
        self.hideKeyboardWhenTappedAround()
        
        if (self.view.frame.width == 320) {
            self.lblConfirmPassword.font = UIFont(name: self.lblChangePassword.font.fontName, size: 12)
            self.lblNewPassword.font = UIFont(name: self.lblNewPassword.font.fontName, size: 12)
            self.lblNewPin.font = UIFont(name: self.lblNewPin.font.fontName, size: 12)
            self.lblChangePassword.font = UIFont.boldSystemFont(ofSize: 14)
            self.btnSubmit.titleLabel?.font =  UIFont(name: "Helvetica", size: 12)
        } else if (self.view.frame.width == 375) {
            self.lblConfirmPassword.font = UIFont(name: self.lblChangePassword.font.fontName, size: 14)
            self.lblNewPassword.font = UIFont(name: self.lblNewPassword.font.fontName, size: 14)
            self.lblNewPin.font = UIFont(name: self.lblNewPin.font.fontName, size: 14)
            self.lblChangePassword.font = UIFont.boldSystemFont(ofSize: 16)
            self.btnSubmit.titleLabel?.font =  UIFont(name: "Helvetica", size: 14)
        } else if (self.view.frame.width == 414) {
            self.lblConfirmPassword.font = UIFont(name: self.lblChangePassword.font.fontName, size: 16)
            self.lblNewPassword.font = UIFont(name: self.lblNewPassword.font.fontName, size: 16)
            self.lblNewPin.font = UIFont(name: self.lblNewPin.font.fontName, size: 16)
            self.lblChangePassword.font = UIFont.boldSystemFont(ofSize: 20)
            self.btnSubmit.titleLabel?.font =  UIFont(name: "Helvetica", size: 16)
        } else if (self.view.frame.width == 768) {
            self.lblConfirmPassword.font = UIFont(name: self.lblChangePassword.font.fontName, size: 32)
            self.lblNewPassword.font = UIFont(name: self.lblNewPassword.font.fontName, size: 32)
            self.lblNewPin.font = UIFont(name: self.lblNewPin.font.fontName, size: 32)
            self.lblChangePassword.font = UIFont.boldSystemFont(ofSize: 45)
            self.btnSubmit.titleLabel?.font =  UIFont(name: "Helvetica", size: 32)
        } else if (self.view.frame.width == 1024) {
            self.lblConfirmPassword.font = UIFont(name: self.lblChangePassword.font.fontName, size: 45)
            self.lblNewPassword.font = UIFont(name: self.lblNewPassword.font.fontName, size: 45)
            self.lblNewPin.font = UIFont(name: self.lblNewPin.font.fontName, size: 45)
            self.lblChangePassword.font = UIFont.boldSystemFont(ofSize: 50)
            self.btnSubmit.titleLabel?.font =  UIFont(name: "Helvetica", size: 45)
        } else {
            self.lblConfirmPassword.font = UIFont(name: self.lblChangePassword.font.fontName, size: 45)
            self.lblNewPassword.font = UIFont(name: self.lblNewPassword.font.fontName, size: 45)
            self.lblNewPin.font = UIFont(name: self.lblNewPin.font.fontName, size: 45)
            self.lblChangePassword.font = UIFont.boldSystemFont(ofSize: 50)
            self.btnSubmit.titleLabel?.font =  UIFont(name: "Helvetica", size: 45)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeRounded(view: btnBack)
        makeRounded(view: btnSubmit)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func togglePassword(state: Bool, textField: UITextField, buttonEye: UIButton) -> Bool {
        
        if state == true {
            textField.isSecureTextEntry = false
            textField.togglePasswordVisibility()
            if #available(iOS 13.0, *) {
                buttonEye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }
        } else {
            textField.isSecureTextEntry = true
            textField.togglePasswordVisibility()
            if #available(iOS 13.0, *) {
                buttonEye.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }
        
        return !state
    }
    
    func changePassword(newPassword: String, confirmPassword: String, newPin: String) {
        self.showLoading()
        let paramLogout = [
            "id_user" : id_user ?? "",
            "password" : newPassword,
            "confirm_password" : confirmPassword,
            "pin" : newPin
        ] as [String : Any]
        
        vm.postChangePassword(body: paramLogout, onSuccess: { response in
            self.hideLoading()
            let alert = UIAlertController(title: "Sukses mengganti password", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                self.back()
            }))
            self.present(alert, animated: true, completion: nil)
        }, onError: { error in
            self.hideLoading()
            let alert = UIAlertController(title: "\(error)", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
            
        }, onFailed: { failed in
            self.hideLoading()
            let alert = UIAlertController(title: "\(failed)", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            }))
            self.present(alert, animated: true, completion: nil)
        })
        self.view.endEditing(true)
    }
    
    @IBAction func btnEyeNewPasswordAction(_ sender: Any) {
        hideNewPassword = togglePassword(state: hideNewPassword, textField: tfNewPassword, buttonEye: btnEyeNewPassword)
    }
    
    @IBAction func btnEyeConfirmPasswordAction(_ sender: Any) {
        hideConfirmPassword = togglePassword(state: hideConfirmPassword, textField: tfConfirmPassword, buttonEye: btnEyeConfirmPassword)
        
    }
    @IBAction func btnEyeNewPinAction(_ sender: Any) {
        hideNewPin = togglePassword(state: hideNewPin, textField: tfNewPin, buttonEye: btnEyeNewPin)
    }
    
    @IBAction func submitChangePasswordButtonTap(_ sender: Any) {
        let newPassword = tfNewPassword.text ?? ""
        let confirmPassword = tfConfirmPassword.text ?? ""
        let newPin = tfNewPin.text ?? ""
        changePassword(
            newPassword: newPassword,
            confirmPassword: confirmPassword,
            newPin: newPin
        )
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        back()
    }
}
