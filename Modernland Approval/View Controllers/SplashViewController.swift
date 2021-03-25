//
//  SplashViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkSessionToken()
        // Do any additional setup after loading the view.
    }
    
    func checkSessionToken() {
        let checkUsername = username ?? ""
        if checkUsername.isEmpty {
            goToLogin()
        } else {
            goToHome()
        }
    }
}
