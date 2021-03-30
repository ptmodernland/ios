//
//  CounterIOM.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 15/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct CounterCompare: Codable {
    let total: String?
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case total
        case status
    }
}
/*
 {
     "total": "5",
     "total_kordinasi": "0",
     "status": true
 }
 */
