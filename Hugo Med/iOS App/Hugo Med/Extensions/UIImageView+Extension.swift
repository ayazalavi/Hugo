//
//  UIImageView+Extension.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/28/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    static func photo(name: String = "") -> UIImageView {
        let imageView = UIImageView()
        if name != "" {
            imageView.image = UIImage(named: name)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
}
