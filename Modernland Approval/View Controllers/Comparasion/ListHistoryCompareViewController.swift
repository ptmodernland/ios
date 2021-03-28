//
//  ListPBJViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 08/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListHistoryCompareViewController: BaseViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var vEmptyState: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    let vm = CompareViewModel()
    var ListCom = [ListCompare]()
    
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
        vm.postListHistoryCompare(
            body: ["username": self.username ?? ""],
            onSuccess: { response in
                self.hideLoading()
                self.ListCom.removeAll()
                for pbj in response {
                    self.ListCom.append(pbj)
                }
                if self.ListCom.isEmpty {
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
extension ListHistoryCompareViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListCom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMenu", for: indexPath) as! ListMenu2TableViewCell
        
        let data = ListCom[indexPath.row].deskripsi!.data(using: .utf8)!
        
        let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        
        cell.lblNomor.text = ListCom[indexPath.row].nomor
        //cell.lblSubTitle.text = ListCom[indexPath.row].deskripsi
        cell.lblSubTitle.attributedText = attributedString
        cell.lblTitle.text = "COMPARASION"
        
        if ListCom[indexPath.row].status == "Y" {
            cell.lblStatus.text = "Waiting Approval"
        }else {
            cell.lblStatus.text = "Approval"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryboardScene.Comparasion.DetailCompareViewController.instantiate()
        vc.idCompare = Int("\(ListCom[indexPath.row].idCompare ?? "")") ?? 0
        vc.type = "history"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

