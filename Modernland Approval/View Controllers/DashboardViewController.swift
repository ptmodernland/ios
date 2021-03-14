//
//  DashboardViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class DashboardViewController: UITabBarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.layer.masksToBounds = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.barStyle = UIBarStyle.black
        self.tabBar.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
        }
        tabBar.barTintColor = UIColor.white
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
