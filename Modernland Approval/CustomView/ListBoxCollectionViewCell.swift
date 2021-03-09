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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        // Initialization code
    }

}
