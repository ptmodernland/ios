//
//  SettingViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutButtonTap(_ sender: Any) {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure to logout?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: { (action) in
            let vc = StoryboardScene.Login.loginViewController.instantiate()
            self.navigationController?.setViewControllers([vc], animated: true)
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
