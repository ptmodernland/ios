//
//  LoginViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        let vc = StoryboardScene.Dashboard.dashboardViewController.instantiate()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}
