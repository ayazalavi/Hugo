//
//  Company.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Company: Codable {
    let id: Int
    let tag: Company_Tag
    let country: Int
    let countries: [Int]
}

struct Company_Tag: Codable {
    let id: Int
    let name: String
    let description: String
    let can_delete: Bool
    let users_count: Int
    let is_active: Bool
}
