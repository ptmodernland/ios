//
//  ListIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class StatusIOMViewController: BaseViewController {
    
    var idIom = ""
    var nomor = ""
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vEmptyState: UIView!
    
    @IBOutlet weak var lblTxtTitle: UILabel!
    
    let vm = IOMViewModel()
    
    var listStatus = [ListStatus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListIom()
        btnBack.layer.cornerRadius = 6
        makeRounded(view: btnBack)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListMenu2TableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListIom() {
        showLoading()
        vm.postListStatus(
            nomorMemo : nomor,
            idIom : idIom,
            onSuccess: { response in
                self.hideLoading()
                self.listStatus.removeAll()
                for status in response {
                    self.listStatus.append(status)
                }
                if self.listStatus.isEmpty {
                    if (self.view.frame.width == 320) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
                    } else if (self.view.frame.width == 375) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
                    } else if (self.view.frame.width == 390) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
                    } else if (self.view.frame.width == 414) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
                    } else if (self.view.frame.width == 428) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
                    }else if (self.view.frame.width == 768) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
                    }else if (self.view.frame.width == 1024) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
                    }
                    self.vEmptyState.isHidden = false
                }
                self.tvList.reloadData()
        }, onError: { error in
            self.hideLoading()
            print(error)
            Toast.show(message: error, controller: self)
        }, onFailed: { failed in
            self.hideLoading()
            print(failed)
            Toast.show(message: failed, controller: self)
        })
    }
  
    
    
    @IBAction func backButtonTap(_ sender: Any) {
        back()
    }
    
}

extension StatusIOMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(listIOM.count)
        return listStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblStatus.text = listStatus[indexPath.row].status_log_iom
        cell.lblTitle.text = "Log Status Iom"
        cell.lblNomor.text = listStatus[indexPath.row].username
        cell.lblSubTitle.text = listStatus[indexPath.row].tgl_log
        
        
        if (self.view.frame.width == 320) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 12)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
        } else if (self.view.frame.width == 375) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 14)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 390) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 14)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 414) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 20)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 20)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 20)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 20)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 428) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 20)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 20)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 20)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 20)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 768) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 22)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 22)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 22)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 22)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
        } else if (self.view.frame.width == 1024) {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 28)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 28)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
        } else {
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 28)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblSubTitle.font = UIFont(name: cell.lblStatus.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 28)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
        }
        
        return cell
    }
    
    
}
