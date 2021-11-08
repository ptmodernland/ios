//
//  DetailIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct DetailKASBON: Codable {
    let nomor: String?
    let tanggal: String?
    let attachments: String?
    let approve: String?
    let status: String?
    let namaUser: String?
    let departemen: String?
    let jumlah: String?
    let keterangan: String?
    
    enum CodingKeys: String, CodingKey {
        case nomor = "no_kasbon"
        case tanggal = "tgl_kasbon"
        case namaUser = "namaUser"
        case departemen = "departemen"
        case attachments = "attch_file"
        case jumlah
        case keterangan
        case approve
        case status
    }
}

