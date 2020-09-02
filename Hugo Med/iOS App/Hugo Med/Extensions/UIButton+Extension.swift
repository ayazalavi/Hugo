//
//  UIButton+Extension.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/28/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    static func mainButton(text: NSAttributedString, radius: CGFloat, backGroundColor: UIColor, spacing: CGFloat = 0.0) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backGroundColor
        let attributedString = NSMutableAttributedString(attributedString: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, text.length))
        button.setAttributedTitle(attributedString, for: .normal)
        button.setAttributedTitle(attributedString, for: .highlighted)
        button.setAttributedTitle(attributedString, for: .selected)
        button.layer.cornerRadius = radius
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func customButton (image: UIImage, tintColor: UIColor, selector: Selector, target: Any) -> UIButton {
        let backButton = UIButton(type: .custom)
        backButton.frame = .zero
        backButton.setImage(image, for: .normal)
        backButton.setImage(image, for: .highlighted)
        backButton.setImage(image, for: .selected)
        backButton.addTarget(target, action: selector, for: .touchUpInside)
        backButton.imageView?.tintColor = tintColor
        return backButton
    }
    
    static func customButton (text: NSAttributedString, icon: UIImage, selector: Selector, target: Any) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = .zero
        button.setImage(icon, for: .normal)
        button.setImage(icon, for: .highlighted)
        button.setImage(icon, for: .selected)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.backgroundColor = .clear
        button.setAttributedTitle(text, for: .normal)
        button.setAttributedTitle(text, for: .highlighted)
        button.setAttributedTitle(text, for: .selected)
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}
