//
//  ListMenuTableViewCell.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 08/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblKategori: UILabel!
    @IBOutlet weak var lblPerihal: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var vLayer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vLayer.layer.cornerRadius = 10
        self.vLayer.layer.borderWidth = 1.0
        self.vLayer.layer.borderColor = UIColor.clear.cgColor
        self.vLayer.layer.masksToBounds = true

        vLayer.layer.shadowColor = UIColor.black.cgColor
        vLayer.layer.shadowOffset = CGSize(width: 0, height: 2)
        vLayer.layer.shadowRadius = 4
        vLayer.layer.shadowOpacity = 0.2
        vLayer.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
