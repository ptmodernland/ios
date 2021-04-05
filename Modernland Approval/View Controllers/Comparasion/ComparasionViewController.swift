//
//  ComparasionViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ComparasionViewController: UIViewController {
    
    @IBOutlet weak var lblTxtTitle: UILabel!
    @IBOutlet weak var lblDashboard: UILabel!
    @IBOutlet weak var cvList: UICollectionView!
    let vm = CompareViewModel()
    let buttonTitleList = ["Waiting Approval for Comparison",
                           "History Approval for Comparison"]
    var notif = ["0","0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
        getCounter()
    }
    
    func setupCollectionView() {
        cvList.delegate = self
        cvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListBoxCollectionViewCell", bundle: nil)
        cvList.register(nearestNib, forCellWithReuseIdentifier: "ListBox")
        cvList.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
    }

    func getCounter() {
        vm.getCounter(onSuccess: { response in
            self.notif.removeAll()
            self.notif = ["0","0","0"]
            self.notif[0] = response.total ?? ""
            self.cvList.reloadData()
        }, onError: { error in
            print(error)
        }, onFailed: { failed in
            print(failed)
        })
    }
}

extension ComparasionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListBox", for: indexPath) as! ListBoxCollectionViewCell
        
        if notif[indexPath.row] == "0" {
            cell.vCounter.isHidden = true
        } else {
            cell.vCounter.isHidden = false
            cell.lblCounter.text = notif[indexPath.row]
        }
        
        cell.lblTitle.text = buttonTitleList[indexPath.row]
        if cell.lblTitle.text!.contains("Waiting") {
            cell.ivTitle.image = UIImage(named: "imgWaiting")
        }
        if cell.lblTitle.text!.contains("History") {
            cell.ivTitle.image = UIImage(named: "imgFolder")
        }
        if cell.lblTitle.text!.contains("Recommendation") {
            cell.ivTitle.image = UIImage(named: "imgCandidates")
        }
        if (self.view.frame.width == 320) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 12)
            cell.lblCounter.font = UIFont(name: cell.lblCounter.font.fontName, size: 12)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 14)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 16)
        } else if (self.view.frame.width == 375) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 14)
            cell.lblCounter.font = UIFont(name: cell.lblCounter.font.fontName, size: 14)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 16)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 18)
        } else if (self.view.frame.width == 414) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 16)
            cell.lblCounter.font = UIFont(name: cell.lblCounter.font.fontName, size: 16)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 18)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 20)
        } else if (self.view.frame.width == 768) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 32)
            cell.lblCounter.font = UIFont(name: cell.lblCounter.font.fontName, size: 32)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 42)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 45)
        } else if (self.view.frame.width == 1024) {
            cell.lblTitle.font = UIFont(name: cell.lblTitle.font.fontName, size: 45)
            cell.lblCounter.font = UIFont(name: cell.lblCounter.font.fontName, size: 45)
            self.lblTxtTitle.font = UIFont.boldSystemFont(ofSize: 50)
            self.lblDashboard.font = UIFont.boldSystemFont(ofSize: 55)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if buttonTitleList[indexPath.row].contains("Waiting") {
            let vc = StoryboardScene.Comparasion.ListCompareViewController.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if buttonTitleList[indexPath.row].contains("History") {
            let vc = StoryboardScene.Comparasion.ListHistoryCompareViewController.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        /*if buttonTitleList[indexPath.row].contains("Recommendation") {
            print("rekomendasi")
        }*/
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
