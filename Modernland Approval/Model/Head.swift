//
//  Head.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 15/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct Head: Codable {
    let username: String?
    let namaUser: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case namaUser
    }
}
