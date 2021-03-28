//
//  ListCategoryIOMViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 26/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//
import UIKit

class ListCategoryIOMViewController: BaseViewController {
    
    @IBOutlet weak var cvList: UICollectionView!
    @IBOutlet weak var btnBack: UIButton!
    
    let vm = IOMViewModel()
    
    let listKategori = [
        "Billionaire Club",
        "Finance Accounting",
        "Quantity Surveyor",
        "Town Management",
        "Technical",
        "Human Resource",
        "Legal Operation",
        "Purchasing",
        "Business Development",
        "Landed Project",
        "Marketing",
        "Permit Certification",
        "Promosi"
    ]
    var notif = ["0","0","0","0","0","0","0","0","0","0","0","0","0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
        getCounter()
    }
    func getCounter() {
        vm.getCounterKategori(onSuccess: { response in
            self.notif.removeAll()
            self.notif = ["0","0","0","0","0","0","0","0","0","0","0","0","0"]
            self.notif[0] = response.totalmarketingclub ?? ""
            self.notif[1] = response.totalfinance ?? ""
            self.notif[2] = response.totalqs ?? ""
            self.notif[3] = response.totaltown ?? ""
            self.notif[4] = response.totalproject ?? ""
            self.notif[5] = response.totalhrd ?? ""
            self.notif[6] = response.totallegal ?? ""
            self.notif[7] = response.totalpurchasing ?? ""
            self.notif[8] = response.totalbdd ?? ""
            self.notif[9] = response.totallanded ?? ""
            self.notif[10] = response.totalmarketing ?? ""
            self.notif[11] = response.totalpermit ?? ""
            self.notif[12] = response.totalpromosi ?? ""
            self.cvList.reloadData()
        }, onError: { error in
            print(error)
        }, onFailed: { failed in
            print(failed)
        })
    }
    
    func setupCollectionView() {
        cvList.delegate = self
        cvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListBoxCollectionViewCell", bundle: nil)
        cvList.register(nearestNib, forCellWithReuseIdentifier: "ListBox")
        cvList.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        back()
    }
}

extension ListCategoryIOMViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listKategori.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListBox", for: indexPath) as! ListBoxCollectionViewCell
        
        cell.lblTitle.text = listKategori[indexPath.row]
        
        if notif[indexPath.row] == "0" {
            cell.vCounter.isHidden = true
        } else {
            cell.vCounter.isHidden = false
            cell.lblCounter.text = notif[indexPath.row]
        }
        
        if cell.lblTitle.text!.contains("Billionaire") {
            cell.ivTitle.image = UIImage(named: "marketing_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Finance") {
            cell.ivTitle.image = UIImage(named: "finance_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Quantity") {
            cell.ivTitle.image = UIImage(named: "qs_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Town") {
            cell.ivTitle.image = UIImage(named: "town_management_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Technical") {
            cell.ivTitle.image = UIImage(named: "project_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Human") {
            cell.ivTitle.image = UIImage(named: "hrd_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Legal") {
            cell.ivTitle.image = UIImage(named: "legal_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Purchasing") {
            cell.ivTitle.image = UIImage(named: "purchasing_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Business") {
            cell.ivTitle.image = UIImage(named: "bdd_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Landed") {
            cell.ivTitle.image = UIImage(named: "landed_project_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Marketing") {
            cell.ivTitle.image = UIImage(named: "marketing_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Permit") {
            cell.ivTitle.image = UIImage(named: "permit_sertification_andro")
            cell.vContent.backgroundColor = .white
        }
        if cell.lblTitle.text!.contains("Promosi") {
            cell.ivTitle.image = UIImage(named: "promosi_andro")
            cell.vContent.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listKategori[indexPath.row].contains("Billionaire") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "1"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Finance") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "2"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Quantity") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "3"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Town") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "4"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Technical") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "5"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Human") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "6"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Legal") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "7"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Purchasing") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "8"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Business") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "9"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Landed") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "10"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Marketing") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "11"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Permit") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "12"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if listKategori[indexPath.row].contains("Promosi") {
            let vc = StoryboardScene.IOM.listKategoriIOMViewController.instantiate()
            vc.divisi_id = "13"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        flowlayout!.minimumInteritemSpacing = 10
        flowlayout!.minimumLineSpacing = 25
        
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) + (flowlayout?.sectionInset.left ?? 0.0) + (flowlayout?.sectionInset.right ?? 0.0)
        
        
        let size:CGFloat = (cvList.frame.size.width - space - 60) / 2.0
        return CGSize(width: size, height: size)
    }
    
}
