//
//  ListBoxCollectionViewCell.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 07/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListBoxCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivTitle: UIImageView!
    @IBOutlet weak var vCounter: UIView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lblCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vCounter.isHidden = true
        vCounter.layer.cornerRadius = vCounter.frame.size.height / 2
        self.vContent.layer.cornerRadius = 10
        self.vContent.layer.borderWidth = 1.0
        self.vContent.layer.borderColor = UIColor.clear.cgColor
        self.vContent.layer.masksToBounds = true

        vContent.layer.shadowColor = UIColor.black.cgColor
        vContent.layer.shadowOffset = CGSize(width: 0, height: 2)
        vContent.layer.shadowRadius = 4
        vContent.layer.shadowOpacity = 0.2
        vContent.layer.masksToBounds = false
        // Initialization code
    }

}
