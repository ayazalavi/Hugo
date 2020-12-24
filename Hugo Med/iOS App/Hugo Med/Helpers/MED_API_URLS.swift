//
//  MED_API_URLS.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct MED_API_URLS {
    private static var production = false
    fileprivate static var api_host: String {
        return production ? "https://api.aliv.io" : "http://test-api.aliv.io"
    }
    static let API_KEY = "UwF7j4gj.WYTKstv0lvhqXPr2kuVmLzP8OerkPpRj"
}

enum MED_API_URL {
    
    case GET_PATIENT_BY_ID(Int)
    case GET_COMPANY_CATALOG(Int)
    case GET_DOCTORS_BY_MICROUNIVERSE(Int)
    case GET_DOCTOR_BY_ID(Int)
    case GET_DOCTOR_SERVICES(Int)
    case REGISTER_ON_DEMAND_APPOINTMENT
    case GET_PATIENT_APPOINTMENT(Int)
    
    enum Endpoints: String {
        case PATIENTS = "/users/patients"
        case COMPANIES = "/companies"
        case DOCTORS = "/users/doctors"
        case SERVICES = "/services"
        case APPOINTMENTS = "/appointments"
    }
    
    func url() -> String {
        switch self {
            case .GET_PATIENT_BY_ID(let patient_id):
                return "\(MED_API_URLS.api_host+Endpoints.PATIENTS.rawValue)?id=\(patient_id)"
            case .GET_COMPANY_CATALOG(let country_id):
                return "\(MED_API_URLS.api_host+Endpoints.COMPANIES.rawValue)?country=\(country_id)"
            case .GET_DOCTORS_BY_MICROUNIVERSE(let company_id):
                return "\(MED_API_URLS.api_host+Endpoints.DOCTORS.rawValue)?company=\(company_id)"
            case .GET_DOCTOR_BY_ID(let doctor_id):
                return "\(MED_API_URLS.api_host+Endpoints.DOCTORS.rawValue)/\(doctor_id)"
            case .GET_DOCTOR_SERVICES(let doctor_id):
                return "\(MED_API_URLS.api_host+Endpoints.SERVICES.rawValue)?id=\(doctor_id)"
            case .REGISTER_ON_DEMAND_APPOINTMENT:
                return MED_API_URLS.api_host + Endpoints.APPOINTMENTS.rawValue
            case .GET_PATIENT_APPOINTMENT(let patient_id):
                return "\(MED_API_URLS.api_host + Endpoints.APPOINTMENTS.rawValue)?patient_id=\(patient_id)"
        }
    }
}

