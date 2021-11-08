//
//  ListHeadKoordinasiViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListHeadKoordinasiViewController: BaseViewController {
    
    let vm = IOMViewModel()
    var listHead = [Head]()
    var nomor = ""
    var idIom = ""
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vEmpty: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListHead()
        makeRounded(view: btnBack)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListNameTableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListName")
    }
    
    func getListHead() {
        showLoading()
        vm.getListHead(
            onSuccess: { response in
                self.hideLoading()
                self.listHead.removeAll()
                for head in response {
                    self.listHead.append(head)
                }
                if self.listHead.isEmpty {
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
    
    func apiProsesRekomendasi(head: String) {
        let idUser = UserDefaults().string(forKey: "idUser")
        
        let param = [
            "nomor" : nomor,
            "id_iom" : idIom,
            "head" : head,
            "ipaddres" : self.getIPAddress(),
            "id_user" : idUser ?? ""
            ] as [String : Any]
        vm.prosesRekomendasi(
            param: param,
            onSuccess: { response in
                 let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
                 self.navigationController?.popToViewController(controller!, animated: true)
        }, onError: { error in
            print(error)
            Toast.show(message: error, controller: self)
        }, onFailed: { failed in
            print(failed)
            Toast.show(message: failed, controller: self)
        })
    }
    
    @IBAction func backButtonTap(_ sender: Any) {
        back()
    }
}

extension ListHeadKoordinasiViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHead.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListName", for: indexPath) as! ListNameTableViewCell
        cell.lblName.text = listHead[indexPath.row].namaUser
        if (self.view.frame.width == 320) {
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 10)
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 12)
        } else if (self.view.frame.width == 375) {
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 12)
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 14)
        } else if (self.view.frame.width == 390) {
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 12)
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 14)
        } else if (self.view.frame.width == 414) {
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 14)
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 16)
        } else if (self.view.frame.width == 428) {
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 14)
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 16)
        } else if (self.view.frame.width == 768) {
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 28)
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 32)
        } else if (self.view.frame.width == 1024) {
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 45)
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 32)
        } else {
            self.lblTitle.font = UIFont(name: self.lblTitle.font.fontName, size: 45)
            cell.lblName.font = UIFont(name: cell.lblName.font.fontName, size: 32)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Anda yakin ingin rekomendasikan ke \(listHead[indexPath.row].namaUser ?? "")?", message: "", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "YA", style: UIAlertAction.Style.default, handler: { (action) in
            self.apiProsesRekomendasi(head: self.listHead[indexPath.row].namaUser ?? "")
        }))
        alert.addAction(UIAlertAction(title: "TIDAK", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
