//
//  ListPBJViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 08/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListHistoryKasbonViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var vEmpty: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTxtTitle: UILabel!
    
    let vm = KasbonViewModel()
    var listKASBON = [ListKASBON]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListPbj()
        makeRounded(view: btnBack)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListMenu2TableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListPbj() {
        showLoading()
        let cariUsername = UserDefaults().string(forKey: "username") ?? ""
        vm.postListHistoryKasbon(
            username : cariUsername,
            onSuccess: { response in
                self.hideLoading()
                self.listKASBON.removeAll()
                for pbj in response {
                    self.listKASBON.append(pbj)
                }
                if self.listKASBON.isEmpty {
                    self.vEmpty.isHidden = false
                    if (self.view.frame.width == 320) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
                    } else if (self.view.frame.width == 375) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
                    } else if (self.view.frame.width == 390) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
                    } else if (self.view.frame.width == 414) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
                    } else if (self.view.frame.width == 428) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
                    } else if (self.view.frame.width == 768) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 45)
                    }else if (self.view.frame.width == 1024) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
                    } else{
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 45)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 50)
                    }
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
extension ListHistoryKasbonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKASBON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblNomor.text = listKASBON[indexPath.row].no_kasbon
        cell.lblSubTitle.text = listKASBON[indexPath.row].tglBuat
        cell.lblTitle.text = "Kasbon"
        
        if listKASBON[indexPath.row].status == "Y" {
            cell.lblStatus.text = "Waiting Approval"
        } else {
            cell.lblStatus.text = "Approval"
        }
        
        if (self.view.frame.width == 320) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 12)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 16)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 12)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 12)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 14)
        } else if (self.view.frame.width == 375) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 14)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 21)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 14)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 390) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 14)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 21)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 14)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 414) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 20)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 20)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 20)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 428) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 20)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 20)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 20)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 768) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 26)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 24)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 24)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 42)
        } else if (self.view.frame.width == 1024) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 26)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 26)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 26)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 50)
        } else {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 26)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 26)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 26)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 45)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 50)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.Kasbon.detailMenuKasbonViewController.instantiate()
        vc.noKasbon = listKASBON[indexPath.row].no_kasbon ?? ""
        vc.idKasbon = listKASBON[indexPath.row].idKasbon ?? ""
        vc.type = "history"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
