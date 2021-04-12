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
    @IBOutlet weak var lblDashboard: UILabel!
    
    let vm = IOMViewModel()
    var divisi_id = ""
    
    var ListKateIOM = [ListKategoriIOM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.layer.cornerRadius = 6
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
        let cariUsername = UserDefaults().string(forKey: "username") ?? ""
        showLoading()
        vm.postListKategoriIom(
            username : cariUsername,
            divisiID: divisi_id,
            onSuccess: { response in
                self.hideLoading()
                self.ListKateIOM.removeAll()
                for kategori in response {
                    self.ListKateIOM.append(kategori)
                }
                if self.ListKateIOM.isEmpty {
                    self.vEmptyState.isHidden = false
                    if (self.view.frame.width == 320) {
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 14)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 16)
                    } else if (self.view.frame.width == 375) {
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 18)
                    } else if (self.view.frame.width == 414) {
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 20)
                    } else if (self.view.frame.width == 768) {
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 42)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 45)
                    }else if (self.view.frame.width == 1024) {
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
                    }else{
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
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
        
        if (self.view.frame.width == 320) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 12)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 16)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 12)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 14)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 375) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 14)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 21)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 14)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 14)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 414) {
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 20)
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 20)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 12)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 20)
        } else if (self.view.frame.width == 768) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 26)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 24)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 24)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 24)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 42)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 45)
        } else if (self.view.frame.width == 1024) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 26)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 26)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 26)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.IOM.detailIOMViewController.instantiate()
        vc.idIom = Int("\(ListKateIOM[indexPath.row].idIom ?? "")") ?? 0
        //vc.type = "recommendation"
            //vc.nomorMemo = ListKateIOM[indexPath.row].nomor ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
