//
//  ListPBJViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 08/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListHistoryPBJViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var vEmpty: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    let vm = PBJViewModel()
    var listPBJ = [ListPBJ]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListPbj()
        makeRounded(view: btnBack)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListMenu2TableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListPbj() {
        showLoading()
        vm.postListHistoryPbj(
            body: ["username": self.username ?? ""],
            onSuccess: { response in
                self.hideLoading()
                self.listPBJ.removeAll()
                for pbj in response {
                    self.listPBJ.append(pbj)
                }
                if self.listPBJ.isEmpty {
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
extension ListHistoryPBJViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPBJ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblNomor.text = listPBJ[indexPath.row].nomor
        cell.lblSubTitle.text = listPBJ[indexPath.row].tglPermintaan
        cell.lblTitle.text = "Permohonan Barang / Jasa"
        
        if listPBJ[indexPath.row].status == "Y" {
            cell.lblStatus.text = "Waiting Approval"
        }else {
            cell.lblStatus.text = "Approval"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.PBJ.detailMenuPBJViewController.instantiate()
        vc.noPermintaan = listPBJ[indexPath.row].nomor!
        vc.type = "history"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
