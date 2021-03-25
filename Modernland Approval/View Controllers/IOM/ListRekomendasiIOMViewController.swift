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
    
    let vm = IOMViewModel()
    var listKoordinasi = [ListKoordinasi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if listKoordinasi[indexPath.row].statusKor == "T" {
            cell.lblStatus.text = "Waiting Approval"
        } else {
            cell.lblStatus.text = "Waiting Approval"
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
