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
    
    var listKategori = [
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        makeRounded(view: btnBack)
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StoryboardScene.IOM.listIOMViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
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
