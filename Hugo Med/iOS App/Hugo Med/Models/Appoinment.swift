//
//  Appoinment.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct Appointment: Codable {
    let id: Int
    let code: String
    let doctor_id: Int
    let patient_ap_maker: Patient
    let is_ondemand: Bool
    let comms_session_id: String
    let appointment_kind: String
    let start_at_date: String
    let start_at_time: String
    let end_at_date: String
    let end_at_time: String
    let motive: String
    let state: String
    let fee: String
    let service_fee: String
    let company_name: String?
    let appointment_origin: Int?
    let paybalance_code: String?
    let paybalance_total: Double?
    let currency: Currency?
}

struct New_Appointment: Codable {
    let place_id: Int
    let type: String
    let doctor_id: Int
    let patient_email: String
    let appointment_kind: String
    let service_id: Int
    let motive: String
    let status_list: String
    let company_id: Int
    let is_ondemand: Bool
}

struct Appointment_Response: Codable {
    let response: Bool
    let code: String
    let datetime: String
}

struct Communication: Codable {
    let api: String
    let videotoken: String
    let session: String
}


