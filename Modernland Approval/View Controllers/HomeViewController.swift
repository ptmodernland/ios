//
//  HomeViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet var imgConstrainHeight: NSLayoutConstraint!
    @IBOutlet var imgConstrainWidth: NSLayoutConstraint!
    
    @IBOutlet var imgConstrainLogoHeight: NSLayoutConstraint!
    @IBOutlet var imgConstrainLogoWidth: NSLayoutConstraint!
    @IBOutlet var imgConstrainLogoTop: NSLayoutConstraint!
    @IBOutlet var homeView: UIView!
    let vm = HomeViewModel()
    
    override func viewDidLoad() {
        if (self.view.frame.width == 320) {
            self.imgConstrainHeight.constant = 49.5
            self.imgConstrainWidth.constant = 212
            self.imgConstrainLogoHeight.constant = 310
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 120
            self.homeView.layoutIfNeeded()
        } else if (self.view.frame.width == 375) {
            self.imgConstrainHeight.constant = 49.5
            self.imgConstrainWidth.constant = 212
            self.imgConstrainLogoHeight.constant = 365
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 120
            self.homeView.layoutIfNeeded()
        } else if (self.view.frame.width == 390) {
            self.imgConstrainHeight.constant = 49.5
            self.imgConstrainWidth.constant = 212
            self.imgConstrainLogoHeight.constant = 365
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 120
            self.homeView.layoutIfNeeded()
        } else if (self.view.frame.width == 414) {
            self.imgConstrainHeight.constant = 49.5
            self.imgConstrainWidth.constant = 212
            self.imgConstrainLogoHeight.constant = 410
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 120
            self.homeView.layoutIfNeeded()
        } else if (self.view.frame.width == 428) {
            self.imgConstrainHeight.constant = 49.5
            self.imgConstrainWidth.constant = 212
            self.imgConstrainLogoHeight.constant = 410
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 120
            self.homeView.layoutIfNeeded()
        } else if (self.view.frame.width == 768) {
            self.imgConstrainHeight.constant = 172
            self.imgConstrainWidth.constant = 568
            self.imgConstrainLogoHeight.constant = 750
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 70
            self.homeView.layoutIfNeeded()
        } else if (self.view.frame.width == 1024) {
            self.imgConstrainHeight.constant = 172
            self.imgConstrainWidth.constant = 568
            self.imgConstrainLogoHeight.constant = 1014
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 20
            self.homeView.layoutIfNeeded()
        } else {
            self.imgConstrainHeight.constant = 172
            self.imgConstrainWidth.constant = 568
            self.imgConstrainLogoHeight.constant = 1014
            self.imgConstrainLogoWidth.constant = 172
            self.imgConstrainLogoTop.constant = 20
            self.homeView.layoutIfNeeded()
        }
        
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCounter()
    }
    func getCounter() {
        let cariUsername = UserDefaults().string(forKey: "username") ?? ""
        vm.getCounter(
            username : cariUsername,
            onSuccess: { [self] response in
                self.tabBarController?.tabBar.items![1].badgeValue = response.total_iom ?? ""
                self.tabBarController?.tabBar.items![2].badgeValue = response.total_permohonan ?? ""
                self.tabBarController?.tabBar.items![3].badgeValue = response.total_compare ?? ""
        }, onError: { error in
            print(error)
        }, onFailed: { failed in
            print(failed)
        })
    }

}
