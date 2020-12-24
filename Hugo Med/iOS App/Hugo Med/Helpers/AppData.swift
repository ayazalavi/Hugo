//
//  Data.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 12/22/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UserNotifications
typealias ParametersAPI = Encodable & Decodable

struct AppData {
    
    static var shared = AppData()
    var current_patient: Patient?
    var doctors: [Doctor]?
    var current_appointment: Appointment?
    var appointment_communication: Appointment_Communication?
    var companies: [Company]?
    var microuniverse_company_id: Int?
    var services: [Service]?
    var current_service: Service?
    var current_doctor: DoctorCard?
    
    private init() {}
    
    mutating func setPatient(_ patient: Patient) {
        current_patient = patient
        current_appointment = nil
        appointment_communication = nil
    }
    
    mutating func setCompanies(_ companies: [Company]) {
        self.companies = companies
        self.microuniverse_company_id = companies.reduce(-1, { (id, company) in
            guard id == -1 else { return id }
            return company.tag.name == "Microuniverse" ? company.tag.id : -1
        })
    }
    
    mutating func setDoctors(_ doctors: [Doctor]) {
        self.doctors = doctors.filter { $0.on_demand && $0.state == "A" }
        print("Total doctors: \(doctors.count), On Demand doctors: \(String(describing: self.doctors?.count))")
    }
    
    mutating func setDoctor(_ doctor: DoctorCard, _ services: [Service]) {
        self.services = services
        self.current_service = services[0]
        self.current_doctor = doctor
    }
    
    func getDoctorsCards() -> [DoctorCard] {
        guard let doctors = doctors else {
            return []
        }
        return doctors.map({ doctor in
            return DoctorCard(photo: doctor.avatar, name: doctor.get_full_name,
                              category: doctor.specialties.map({ $0.name }).reduce("", {$0 == "" ? $1 : $0+", "+$1}),
                              isAvailable: doctor.waiting_time.waiting == 0, availableIn: doctor.waiting_time.waiting, id: doctor.id)
        })
    }
    
    func getDoctorCard(doctor: Doctor) -> DoctorCard {
        return DoctorCard(photo: doctor.avatar, name: doctor.get_full_name,
                              category: doctor.specialties.map({ $0.name }).reduce("", {$0 == "" ? $1 : $0+", "+$1}),
                              isAvailable: doctor.waiting_time.waiting == 0, availableIn: doctor.waiting_time.waiting, id: doctor.id)
    }
    
    func checkNotification(doctor: DoctorCard, reschedule: Bool) {
        let center =  UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { requests in
            if requests.count == 0 {
                print("notification: reset")
                setNotification(seconds: doctor.availableIn)
            }
        }
    }
    
    func setNotification(seconds: Int) {
        let center =  UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
            if result {
                center.removeAllPendingNotificationRequests()
                print("notification: removed")
                //create the content for the notification
                let content = UNMutableNotificationContent()
                content.title = "Hugo App"
                content.subtitle = "¡El doctor(a) está listo!"
                content.body = "Estamos listo para comenzar tu consulta médica con hugoMed conectate para comenzar la llamada"
                content.sound = UNNotificationSound.default

                //notification trigger can be based on time, calendar or location
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval:TimeInterval(5), repeats: false)
                
                let uuidString = UUID().uuidString
                //create request to display
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

                //add request to notification center
                center.add(request) { (error) in
                    if error != nil {
                        print("error \(String(describing: error))")
                    }
                }
                print("notification: set")
            }
        }
    }
}
