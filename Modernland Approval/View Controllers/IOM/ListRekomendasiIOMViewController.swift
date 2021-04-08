//
//  ListRekomendasiIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListRekomendasiIOMViewController: BaseViewController {
    
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vEmpty: UIView!
    
    @IBOutlet weak var lblTxtTitle: UILabel!
    @IBOutlet weak var lblDashboard: UILabel!
    let vm = IOMViewModel()
    var listKoordinasi = [ListKoordinasi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListIom()
        makeRounded(view: btnBack)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListMenu2TableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListIom() {
        showLoading()
        vm.listKoordinasi(
            body: ["username": self.username ?? ""],
            onSuccess: { response in
                self.hideLoading()
                self.listKoordinasi.removeAll()
                for koordinasi in response {
                    self.listKoordinasi.append(koordinasi)
                }
                if self.listKoordinasi.isEmpty {
                    if (self.view.frame.width == 320) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 16)
                    } else if (self.view.frame.width == 375) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 18)
                    } else if (self.view.frame.width == 414) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 20)
                    } else if (self.view.frame.width == 768) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 45)
                    }else if (self.view.frame.width == 1024) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
                    } else {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
                    }
                    self.vEmpty.isHidden = false
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
extension ListRekomendasiIOMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listKoordinasi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblNomor.text = listKoordinasi[indexPath.row].nomor
        cell.lblTitle.text = listKoordinasi[indexPath.row].perihal
        cell.lblSubTitle.text = "Dari : \(listKoordinasi[indexPath.row].approve ?? "") | Kepada : \(listKoordinasi[indexPath.row].koordinasi ?? "")"
        
        if listKoordinasi[indexPath.row].statusKor == "T" && listKoordinasi[indexPath.row].statusEmail == "T"{
            cell.lblStatus.text = "Waiting Approval"
        } else {
            cell.lblStatus.text = "Approval"
        }
        if (self.view.frame.width == 320) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 12)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 16)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 12)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 375) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 14)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 21)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 14)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 414) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 20)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 20)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 20)
        } else if (self.view.frame.width == 768) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 26)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 24)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 24)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 45)
        }else if (self.view.frame.width == 1024) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 26)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 26)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 26)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
        } else {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 26)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 26)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 26)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.IOM.detailIOMViewController.instantiate()
        vc.idIom = Int("\(listKoordinasi[indexPath.row].idIom ?? "")") ?? 0
        vc.type = "rekomendasi"
        vc.nomorMemo = listKoordinasi[indexPath.row].nomor ?? ""
        vc.idKoordinasi = listKoordinasi[indexPath.row].idKordinasi ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
