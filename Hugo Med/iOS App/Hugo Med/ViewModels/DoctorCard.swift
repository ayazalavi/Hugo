//
//  DoctorCell.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/29/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct DoctorCard {
    let photo, name, category: String
    let isAvailable: Bool
    let availableIn: Int
    let id: Int
    
    func getMinsAvailability () -> Int {
        return Int(ceil(Double(self.availableIn)/60.0))
    }
}
