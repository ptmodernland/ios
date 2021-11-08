//
//  ListIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct ListStatus: Codable {
    let status_log_iom: String?
    let username: String?
    let tgl_log: String?
    
    enum CodingKeys: String, CodingKey {
        case tgl_log
        case status_log_iom
        case username
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
