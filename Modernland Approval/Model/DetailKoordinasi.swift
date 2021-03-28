//
//  DetailKoordinasi.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 17/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct DetailKoordinasi: Codable {
    let idKoordinasi: String?
    let nomor: String?
    let kepada: String?
    let cc: String?
    let dari: String?
    let tanggal: String?
    let jenis: String?
    let perihal: String?
    let attachments: String?
    let approve: String?
    let status: String?
    let statusEmail: String?
    
    
    enum CodingKeys: String, CodingKey {
        case idKoordinasi = "id_koordinasi"
        case nomor
        case kepada
        case cc
        case dari
        case tanggal
        case jenis
        case perihal
        case attachments = "attch_lampiran"
        case approve
        case status
        case statusEmail = "status_email"
    }
}
