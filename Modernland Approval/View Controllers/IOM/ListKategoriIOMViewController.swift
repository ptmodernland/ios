//
//  ListIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListKategoriIOMViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vEmptyState: UIView!
    
    let vm = IOMViewModel()
    var divisi_id = ""
    
    var ListKateIOM = [ListKategoriIOM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        getListKategoriIom()
        makeRounded(view: btnBack)
    }
    
    func setupTableView() {
        tvList.delegate = self
        tvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListMenu2TableViewCell", bundle: nil)
        tvList.register(nearestNib, forCellReuseIdentifier: "ListMenu")
    }
    
    func getListKategoriIom() {
        showLoading()
        vm.postListKategoriIom(
            divisiID: divisi_id,
            onSuccess: { response in
                self.hideLoading()
                self.ListKateIOM.removeAll()
                for kategori in response {
                    self.ListKateIOM.append(kategori)
                }
                if self.ListKateIOM.isEmpty {
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

extension ListKategoriIOMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(listIOM.count)
        return ListKateIOM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblNomor.text = ListKateIOM[indexPath.row].nomor
        cell.lblTitle.text = ListKateIOM[indexPath.row].perihal
        cell.lblSubTitle.text = ListKateIOM[indexPath.row].approve
        
        if ListKateIOM[indexPath.row].status == "Y" {
            cell.lblStatus.text = "Waiting Approval"
        } else {
            cell.lblStatus.text = "Approval"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.IOM.detailIOMViewController.instantiate()
        vc.idIom = Int("\(ListKateIOM[indexPath.row].idIom ?? "")") ?? 0
        vc.type = "recommendation"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
