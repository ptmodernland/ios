//
//  CounterIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 15/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct CounterKateori: Codable {
    let totalmarketingclub: String?
    let totalfinance: String?
    let totalqs: String?
    let totallegal: String?
    let totalpurchasing: String?
    let totalbdd: String?
    let totalproject: String?
    let totalpromosi: String?
    let totalmarketing: String?
    let totalhrd: String?
    let totallanded: String?
    let totaltown: String?
    let totalpermit: String?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case totalmarketingclub = "total_marketing_club"
        case totalfinance = "total_finance"
        case totalqs = "total_qs"
        case totallegal = "total_legal"
        case totalpurchasing = "total_purchasing"
        case totalbdd = "total_bdd"
        case totalproject = "total_project"
        case totalpromosi = "total_promosi"
        case totalmarketing = "total_marketing"
        case totalhrd = "total_hrd"
        case totallanded = "total_landed"
        case totaltown = "total_town"
        case totalpermit = "total_permit"
        case status
    }
}
/*
 {
 $hasil["total_marketing_club"] = $baris_marketing_club->total;
     $hasil["total_finance"] = $baris_finance->total;
     $hasil["total_qs"] = $baris_qs->total;
     $hasil["total_legal"] = $baris_legal->total;
     $hasil["total_purchasing"] = $baris_purchasing->total;
     $hasil["total_bdd"] = $baris_bdd->total;
     $hasil["total_project"] = $baris_project->total;
     $hasil["total_promosi"] = $baris_promosi->total;
     $hasil["total_marketing"] = $baris_marketing->total;
     $hasil["total_hrd"] = $baris_hrd->total;
     $hasil["total_landed"] = $baris_landed->total;
     $hasil["total_town"] = $baris_town->total;
     $hasil["total_permit"] = $baris_permit->total;
     $hasil["status"] = true;
 }
 */
