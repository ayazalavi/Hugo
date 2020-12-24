//
//  Patient.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/30/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Patient: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let country_id: Int?
    let date_of_birth: String?
    let created_at: String?
    let state: String?
}
