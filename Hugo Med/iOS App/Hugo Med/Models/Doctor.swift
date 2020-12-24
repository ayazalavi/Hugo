//
//  Doctor.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Doctor: Codable {
    let id: Int
    let email: String
    let slug: String
    let get_full_name: String
    let avatar: String
    let specialties: [Speciality]
    let country: Int
    let on_demand: Bool
    let state: String
    var waiting_time: Waiting_time
}

struct Waiting_time: Codable {
    var waiting: Int
    let num: Int
}

struct Speciality: Codable {
    let id: Int
    let name: String
    let slug: String
}
