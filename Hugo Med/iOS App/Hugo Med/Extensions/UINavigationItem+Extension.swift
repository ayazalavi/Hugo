//
//  UINavigationItem+Extension.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/29/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    // MARK: Customizing functions
    
    func addImageTitleViewWith(image: String, with tintColor: UIColor) {
        let titleView = UIImageView.photo(name: image)
        titleView.image = titleView.image?.withRenderingMode(.alwaysTemplate)
        titleView.tintColor = tintColor
        titleView.setNeedsLayout()
        self.titleView = titleView
    }
    
    func setTintColors(for bar: UINavigationBar?, color: UIColor, itemsColor: UIColor) {
        self.titleView?.tintColor = itemsColor
        if let leftButton = self.leftBarButtonItem?.customView as? UIButton  {
            leftButton.imageView?.tintColor = itemsColor
        }
        if let rightButton = self.rightBarButtonItem?.customView as? UIButton  {
            rightButton.imageView?.tintColor = itemsColor
        }
        bar?.barTintColor = color
    }
    
    func addTitleText(text: String, and textColor: UIColor) {
        self.title = text
        
    }
    
    func removeTitleView() {
        self.titleView = nil
        self.title = ""
    }
    
    func setBackButton(target: Any, selector: Selector) {
        self.setHidesBackButton(false, animated: true)
        
    }
    
    func setRightButton(_ button: UIButton) {
        self.setRightBarButton(UIBarButtonItem(customView: button), animated: true)
    }
    
}
