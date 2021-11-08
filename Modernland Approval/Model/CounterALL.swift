//
//  CounterALL.swift
//  Modernland Approval
//
//  Created by ITMLR-01 on 11/8/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct CounterALL: Codable {
    let total_iom: String?
    let total_permohonan: String?
    let total_compare: String?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case total_iom
        case total_permohonan
        case total_compare
        case status
    }
}
