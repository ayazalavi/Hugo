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
