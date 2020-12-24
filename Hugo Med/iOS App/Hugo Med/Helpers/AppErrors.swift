//
//  Errors.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation


enum AppErrors: Error {
    case PatientNotSet, NoResponse, CompaniesNotFound, DoctorsError, DoctorServiceNotSet, AppointmentNotMade
    case AppointmentNotExist, OpenTokSessionNotMade, OpenTokConnectionNoMade
}
