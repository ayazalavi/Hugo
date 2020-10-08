//
//  UIViewController+Extension.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addNavigationBar(leftBarButton: UIBarButtonItem?, centerText: NSMutableAttributedString, rightBarButtons: [UIBarButtonItem]?) {
        if navigationController != nil {
            setNavigationBar(leftBarButton: leftBarButton, centerText: centerText, rightBarButtons: rightBarButtons)
        }
        else {
            
        }
    }
    
    func makeNavigationTransparent(transparent: Bool) {
        if transparent {
            //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
          //  self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.barTintColor = .orange
        }
        else {
            self.navigationController?.view.backgroundColor = .white
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    func setNavBarVisibility(value: Bool) {
        self.navigationController?.setNavigationBarHidden(value, animated: false)
    }
    
    func setNavigationBar(leftBarButton: UIBarButtonItem?, centerText: NSMutableAttributedString, rightBarButtons: [UIBarButtonItem]?) {
        self.navigationItem.rightBarButtonItems = rightBarButtons
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        centerText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purpleNavigationBar, range: NSRange(location: 0, length: centerText.length))
        self.navigationController?.navigationBar.titleTextAttributes = centerText.attributes(at: 0, effectiveRange: nil)
        self.title = centerText.string
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.backgroundColor = .white
    }
    
}

public extension UINavigationBar {
    
    func setBarColor(_ barColor: UIColor?) {
        
        if barColor != nil && barColor!.cgColor.alpha == 0 {
            // if transparent color then use transparent nav bar
            self.setBackgroundImage(UIImage(), for: .default)
            self.hideShadow(true)
        }
        else if barColor != nil {
            // use custom color
            self.setBackgroundImage(self.image(with: barColor!), for: .default)
            self.hideShadow(false)
        }
        else {
            // restore original nav bar color
            self.setBackgroundImage(nil, for: .default)
            self.hideShadow(false)
        }
    }
    
    func hideShadow(_ doHide: Bool) {
        self.shadowImage = doHide ? UIImage() : nil
    }
    
    func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
