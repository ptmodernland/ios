//
//  Status.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct Status: Codable {
    let status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case status
    }
}
