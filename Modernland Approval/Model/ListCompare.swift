//
//  ListIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct ListCompare: Codable {
    let idCompare: String?
    let nomor: String?
    let deskripsi: String?
    let approve: String?
    let status: String?
    let statusEmail: String?
    let koordinasi: String?
    
    enum CodingKeys: String, CodingKey {
        case idCompare = "id_compare"
        case nomor = "no_compare"
        case deskripsi = "desc_compare"
        case approve
        case status
        case statusEmail = "status_email"
        case koordinasi
    }
}

/*
 {
 "id_iom": "43",
 "nomor": "001/XI/2020",
 "perihal": "test",
 "approve": "obet",
 "status": "T",
 "status_email": "T",
 "kordinasi": "T"
 }
 */
