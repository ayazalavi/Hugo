//
//  Services.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Service: Codable {
    let id: Int
    let name: String
    let description: String
    let fee: String
    let doctor: Int
    let currency: Currency
}
