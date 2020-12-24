//
//  Currency.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let id: Int
    let name: String
    let logo: String?
    let symbol: String?
    let short_name: String?
    let description: String?
}
