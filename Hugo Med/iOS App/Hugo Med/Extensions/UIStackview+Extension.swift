//
//  UIStackview+Extension.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/28/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    subscript(index: Int) -> UIImage? {
        get {
            if let view_ = self.subviews[index] as? UIImageView, let image = view_.image {
                return image
            }
            return nil
        }
        set {
            if let view_ = self.subviews[index] as? UIImageView {
                view_.image = newValue
            }
        }
    }
    
    func updateImageViewAt(index: Int) {
        for i in 0..<self.subviews.count {
            if let view_ = self.subviews[i] as? UIImageView {
                if i == index {
                    view_.image = UIImage(named: "active")
                }
                else {
                    view_.image = UIImage(named: "inactive")
                }
            }
        }
    }
}
