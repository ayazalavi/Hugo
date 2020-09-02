//
//  Storage.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/29/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation


var doctors: [DoctorCard] = [
    DoctorCard(photo: "Avatarimage", name: "Carmen Beltrán", category: "Médico general", isAvailable: true, availableIn: 5),
    DoctorCard(photo: "Avatar", name: "Lissette Flores", category: "Médico general", isAvailable: true, availableIn: 8),
    DoctorCard(photo: "Avatarimage", name: "Carmen Beltrán", category: "Médico general", isAvailable: true, availableIn: 4),
    DoctorCard(photo: "Avatar", name: "Lissette Flores", category: "Médico general", isAvailable: true, availableIn: 3),
    DoctorCard(photo: "Avatarimage", name: "Carmen Beltrán", category: "Médico general", isAvailable: true, availableIn: 1),
    DoctorCard(photo: "Avatar", name: "Lissette Flores", category: "Médico general", isAvailable: false, availableIn: 10),
    DoctorCard(photo: "Avatarimage", name: "Carmen Beltrán", category: "Médico general", isAvailable: false, availableIn: 30),
    DoctorCard(photo: "Avatar", name: "Lissette Flores", category: "Médico general", isAvailable: false, availableIn: 15),
    DoctorCard(photo: "Avatarimage", name: "Carmen Beltrán", category: "Médico general", isAvailable: false, availableIn: 5),
]

var lastConsulationRequest: ConsulationStatus = .none
var startConsulation = false

//

var FAQs: [FAQ] {
    var faqs = [FAQ]()
    for _ in 0...10 {
        faqs.append(FAQ(shortText: "¿Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed ligula nulla?", detailedText: "Sed aliquam nec diam eu ultricies. Curabitur mollis sollicitudin lacus, sed aliquet nisi molestie a. Aenean quis consectetur est, nec luctus risus. Etiam fringilla feugiat metus, tincidunt aliquam sapien malesuada vel. Nulla at ultricies ante, sed mattis ipsum. Fusce dignissim maximus massa id aliquet."))
    }
    return faqs
}
