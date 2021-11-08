//
//  DetailIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct DetailRealisasi: Codable {
    let nomor: String?
    let tanggal: String?
    let attachments: String?
    let approve: String?
    let status: String?
    let namaUser: String?
    let departemen: String?
    let no_kasbon: String?
    
    enum CodingKeys: String, CodingKey {
        case nomor = "no_realisasi"
        case tanggal = "tgl_realisasi"
        case namaUser = "namaUser"
        case departemen = "departemen"
        case attachments = "attch_file"
        case no_kasbon
        case approve
        case status
    }
}

