//
//  DetailIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct DetailPBJ: Codable {
    let nomor: String?
    let tanggal: String?
    let attachments: String?
    let approve: String?
    let status: String?
    let koordinasi: String?
    let kategoriIom: String?
    
    
    enum CodingKeys: String, CodingKey {
        case nomor = "no_permintaan"
        case tanggal = "tgl_permintaan"
        case attachments = "attch_lampiran"
        case approve
        case status
        case koordinasi = "kordinasi"
        case kategoriIom = "kategori_iom"
    }
}

/*
 {
 "nomor": "004/IOM/CS-TM/JGC/II/2021",
 "kepada": "Bpk. David Iman Santosa;Bpk. Herman ",
 "cc": "Bpk. Togu Pangihutan;Ibu Jinny",
 "dari": "Yandi Ramayadi",
 "tanggal": "02-February-2021",
 "jenis": "IOM PEMBERITAHUAN",
 "perihal": "Pengajuan Discount 20% Pembayaran IPKL  D'Banyan E-173, Palm Spring F-123 & F-177",
 "attch_lampiran": "E-173-F-177-F-123.pdf",
 "approve": "yandi",
 "status": "T",
 "kordinasi": "T",
 "kategori_iom": "Pengajuan Discount "
 }
 */
