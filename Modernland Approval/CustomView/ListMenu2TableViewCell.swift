//
//  ListMenu2TableViewCell.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 09/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListMenu2TableViewCell: UITableViewCell {

    @IBOutlet weak var vStatus: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vStatus.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
