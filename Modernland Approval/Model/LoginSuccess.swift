//
//  LoginSuccess.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 14/03/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import Foundation

struct LoginSuccess: Codable {
    let status: Bool?
    let idUser: String?
    let username: String?
    let name: String?
    let level: String?
    let email: String?
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case idUser = "id_user"
        case username
        case name = "nama"
        case level
        case email
        case gender = "jk"
    }
}
