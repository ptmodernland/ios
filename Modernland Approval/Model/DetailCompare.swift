//
//  DetailIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct DetailCompare: Codable {
    let nomor: String?
    let tanggal: String?
    let attach: String?
    let approve: String?
    let status: String?
    let noRef: String?
    let deptUser: String?
    let descCompare: String?
    let advancePayment: String?
    let progresPayment: String?
    let pajakReklame: String?
    
    
    enum CodingKeys: String, CodingKey {
        case nomor = "no_compare"
        case tanggal = "compare_date"
        case attach = "attch_lampiran"
        case approve
        case status
        case noRef = "no_ref"
        case deptUser = "dept_user"
        case descCompare = "desc_compare"
        case advancePayment = "advance_payment"
        case progresPayment = "progres_payment"
        case pajakReklame = "pajak_reklame"
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
