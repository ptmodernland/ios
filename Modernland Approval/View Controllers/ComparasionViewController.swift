//
//  ComparasionViewController.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ComparasionViewController: UIViewController {
    
    @IBOutlet weak var cvList: UICollectionView!
    
    let buttonTitleList = ["Waiting Approval for Comparison",
                           "History Approval for Comparison"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        cvList.delegate = self
        cvList.dataSource = self
        
        let nearestNib = UINib.init(nibName: "ListBoxCollectionViewCell", bundle: nil)
        cvList.register(nearestNib, forCellWithReuseIdentifier: "ListBox")
        cvList.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
    }
    
}

extension ComparasionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListBox", for: indexPath) as! ListBoxCollectionViewCell
        
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
        return cell
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
