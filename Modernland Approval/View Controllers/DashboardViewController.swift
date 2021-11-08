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
        
        if (self.view.frame.width == 320) {
            let font = UIFont(name: "Helvetica", size: 12)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else if (self.view.frame.width == 375) {
            let font = UIFont(name: "Helvetica", size: 14)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else if (self.view.frame.width == 390) {
            let font = UIFont(name: "Helvetica", size: 14)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else if (self.view.frame.width == 414) {
            let font = UIFont(name: "Helvetica", size: 16)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else if (self.view.frame.width == 428) {
            let font = UIFont(name: "Helvetica", size: 16)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }else if (self.view.frame.width == 768) {
            let font = UIFont(name: "Helvetica", size: 21)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else if (self.view.frame.width == 1024) {
            let font = UIFont(name: "Helvetica", size: 21)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        } else {
            let font = UIFont(name: "Helvetica", size: 21)!
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        }
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}
