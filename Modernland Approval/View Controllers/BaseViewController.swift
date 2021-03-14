//
//  BaseViewController.swift
//  IBID
//
//  Created by Kevin Correzian on 11/03/20.
//  Copyright © 2020 PT. Serasi Autoraya (SERA). All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {
    var delegate = UIGestureRecognizerDelegate?.self
    var isInitialized: Bool = false
    var swipeBackEnabled: Bool = true
    let refreshControl = UIRefreshControl()
    let username = UserDefaults().string(forKey: "username")
    let hud = JGProgressHUD()

    open var rootViewController: UIViewController? {
        get {
            guard let firstWindow = UIApplication.shared.delegate?.window else { return nil }
            return firstWindow?.rootViewController
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        onViewLoaded()
    }
    func onViewLoaded() {}
    override func viewDidAppear(_ animated: Bool) {
        
        onViewAppeared()
    }
    
    func onViewAppeared() {}
    
    override func viewWillDisappear(_ animated: Bool) {
        //        ApiHelper().cancelAllRequest()
        onViewWillDisappeared()
    }
    
    func onViewWillDisappeared() {}
    
    override func viewDidDisappear(_ animated: Bool) {
        onViewDisappeared()
    }
    
    func onViewDisappeared() {}
    
    // MARK: - Navigation
    
    func back() {
        if swipeBackEnabled {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func goToLogin() {
        let vc = StoryboardScene.Login.loginViewController.instantiate()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func goToHome() {
        let vc = StoryboardScene.Dashboard.dashboardViewController.instantiate()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "userFirstInstall") {
            return true
        } else {
            defaults.set(true, forKey: "userFirstInstall")
            return false
        }
    }
    
    func showLoading() {
        hud.textLabel.text = "Loading"
        hud.style = .dark
        hud.show(in: self.view)
    }
    
    func hideLoading() {
        hud.dismiss()
    }
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension BaseViewController: UIGestureRecognizerDelegate {
    
}
