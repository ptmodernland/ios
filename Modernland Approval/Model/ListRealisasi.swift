//
//  ListIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct ListRealisasi: Codable {
    let idRealisasi: String?
    let no_realisasi: String?
    let no_kasbon: String?
    let approve: String?
    let status: String?
    let statusEmail: String?
    let dari: String?
    let tglBuat: String?
    
    enum CodingKeys: String, CodingKey {
        case idRealisasi = "id_realisasi"
        case no_realisasi
        case no_kasbon
        case approve
        case dari = "namaUser"
        case tglBuat = "tgl_buat"
        case status
        case statusEmail = "status_email"
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
