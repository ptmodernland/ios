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
    @IBOutlet weak var lblTxtTitle: UILabel!
    
    let vm = CompareViewModel()
    var ListCom = [ListCompare]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.layer.cornerRadius = 6
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
                    if (self.view.frame.width == 320) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
                    } else if (self.view.frame.width == 375) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
                    } else if (self.view.frame.width == 414) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
                    } else if (self.view.frame.width == 768) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 45)
                    } else if (self.view.frame.width == 1024) {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
                    } else {
                        self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
                        self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
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
        } else if (self.view.frame.width == 414) {
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
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
        } else {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 28)
            cell.lblNomor.font = UIFont(name: cell.lblNomor.font.fontName, size: 26)
            cell.lblSubTitle.font = UIFont(name: cell.lblSubTitle.font.fontName, size: 26)
            cell.lblStatus.font = UIFont(name: cell.lblStatus.font.fontName, size: 26)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblTitle.font = UIFont.boldSystemFont(ofSize: 55)
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

