//
//  ListNameTableViewCell.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 15/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit

class ListNameTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
