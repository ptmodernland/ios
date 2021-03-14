//
//  BaseResponse.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 10/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct BaseResponse: Codable {
    let status: Bool?
    let pesan: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case pesan
    }
}
