//
//  OnBoarding.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

struct OnBoarding {
    let photo: String
    let titleContent, descriptionContent: Content
    
    init(photo: String, title: Content, description: Content) {
        self.photo = photo
        self.titleContent = title
        self.descriptionContent = description
    }
}
