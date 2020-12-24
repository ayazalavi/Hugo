//
//  Data.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Data {
    
    static let shared = Data()
    var current_patient: Patient?
    var doctors: [Doctor]?
    var current_appointment: Appointment?
    var appointment_communication: New_Appointment?
    
    private init() {}
    
    mutating func setPatient(_ patient: Patient) {
        current_patient = patient
        current_appointment = nil
        appointment_communication = nil
    }
}
