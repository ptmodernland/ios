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

    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vEmpty: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListHead()
        makeRounded(view: btnBack)
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
            "id" : idIom,
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
