//
//  UIFont+Extension.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/28/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static var defaultFont: UIFont { UIFont.systemFont(ofSize: 10) }
    
    static func getFont(name: String, size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size) ?? UIFont.defaultFont
    }
}
