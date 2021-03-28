//
//  PBJViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 07/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class PBJViewController: BaseViewController {
    
    @IBOutlet weak var cvList: UICollectionView!
    
    let vm = PBJViewModel()
    let buttonTitleList = ["Waiting Approval for PBJ",
                           "History Approval for PBJ",
                           //"List Recommendation"
                            ]
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
            self.notif[1] = response.totalKoordinasi ?? ""
            self.cvList.reloadData()
        }, onError: { error in
            print(error)
        }, onFailed: { failed in
            print(failed)
        })
    }
    
}

extension PBJViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListBox", for: indexPath) as! ListBoxCollectionViewCell
        
        cell.lblTitle.text = buttonTitleList[indexPath.row]
        
        if notif[indexPath.row] == "0" {
            cell.vCounter.isHidden = true
        } else {
            cell.vCounter.isHidden = false
            cell.lblCounter.text = notif[indexPath.row]
        }
        
        if cell.lblTitle.text!.contains("Waiting") {
            cell.ivTitle.image = UIImage(named: "imgWaiting")
        }
        if cell.lblTitle.text!.contains("History") {
            cell.ivTitle.image = UIImage(named: "imgFolder")
        }
        /*if cell.lblTitle.text!.contains("Recommendation") {
            cell.ivTitle.image = UIImage(named: "imgCandidates")
        }*/
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if buttonTitleList[indexPath.row].contains("Waiting") {
            let vc = StoryboardScene.PBJ.listPBJViewController.instantiate()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if buttonTitleList[indexPath.row].contains("History") {
            let vc = StoryboardScene.PBJ.listHistoryPBJViewController.instantiate()
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
