//
//  ListKoordinasi.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 15/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct ListKoordinasi: Codable {
    let idKordinasi: String?
    let idIom: String?
    let nomor: String?
    let perihal: String?
    let approve: String?
    let statusKor: String?
    let statusEmail: String?
    let namaUser: String?
    let koordinasi: String?
    
    enum CodingKeys: String, CodingKey {
        case idKordinasi = "id_kordinasi"
        case idIom = "id_iom"
        case nomor
        case perihal
        case approve
        case statusKor = "status_kor"
        case statusEmail = "status_email"
        case namaUser
        case koordinasi = "UserKordinasi"
    }
}
/*
{
    "id_kordinasi": "22",
    "id_iom": "43",
    "nomor": "001/XI/2020",
    "perihal": "test",
    "approve": "aritio",
    "status_kor": "T",
    "status_email": "T",
    "namaUser": "Aritio",
    "UserKordinasi": "obet"
}
*/
