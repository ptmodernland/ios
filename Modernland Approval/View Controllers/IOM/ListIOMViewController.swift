//
//  ListIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListIOMViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var vEmptyState: UIView!
    
    let vm = IOMViewModel()
    
    var listIOM = [ListIOM]()
    
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
        vm.postListIom(
            body: ["username": self.username ?? ""],
            onSuccess: { response in
                self.hideLoading()
                self.listIOM.removeAll()
                for iom in response {
                    self.listIOM.append(iom)
                }
                if self.listIOM.isEmpty {
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

extension ListIOMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(listIOM.count)
        return listIOM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        cell.lblNomor.text = listIOM[indexPath.row].nomor
        cell.lblTitle.text = listIOM[indexPath.row].perihal
        cell.lblSubTitle.text = listIOM[indexPath.row].approve
        
        if listIOM[indexPath.row].status == "Y" {
            cell.lblStatus.text = "Waiting Approval"
        } else {
            cell.lblStatus.text = "Approval"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.IOM.detailIOMViewController.instantiate()
        vc.idIom = Int("\(listIOM[indexPath.row].idIom ?? "")") ?? 0
        vc.type = "recommendation"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
