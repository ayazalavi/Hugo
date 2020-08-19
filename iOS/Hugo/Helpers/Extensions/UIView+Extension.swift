//
//  UIView+Extension.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func insertConstraintsFor(top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: top),
            self.bottomAnchor.constraint(equalTo: bottom),
            self.leadingAnchor.constraint(equalTo: leading),
            self.trailingAnchor.constraint(equalTo: trailing),
        ])
    }
    
    func insertConstraintsFor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: top),
            self.leadingAnchor.constraint(equalTo: leading),
            self.trailingAnchor.constraint(equalTo: trailing),
        ])
    }
    
    func insertConstraintsFor(bottom: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: bottom),
            self.leadingAnchor.constraint(equalTo: leading),
            self.trailingAnchor.constraint(equalTo: trailing),
        ])
    }
    
    func insertConstraintsFor(width: NSLayoutDimension, height: Double) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: width),
            self.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}

extension UIScrollView {
    

    func computeMainContentHeight (sizes: [CGRect]) {
        
        self.contentSize.height = sizes.reduce(0) { max($0, $1.origin.y)+$1.height}
        
        print("Scrolview size \(sizes) \(contentSize)")
    }
    
}

extension UIButton {
    
    static func backButton (color: UIColor, selector: Selector, target: Any, size: CGSize) -> UIButton {
        let backButton = UIButton(type: .custom)
        backButton.frame = .zero
        backButton.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        backButton.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .selected)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        backButton.addTarget(target, action: selector, for: .touchUpInside)
        backButton.imageView?.tintColor = color
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: size.width),
            backButton.heightAnchor.constraint(equalToConstant: size.height)
        ])
        return backButton
    }
    
    static func closeButton (color: UIColor, selector: Selector, target: Any, size: CGSize) -> UIButton {
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(origin: .zero, size:  size)
        backButton.setImage(UIImage(named: "icon_close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.setImage(UIImage(named: "icon_close")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        backButton.setImage(UIImage(named: "icon_close")?.withRenderingMode(.alwaysTemplate), for: .selected)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        backButton.addTarget(target, action: selector, for: .touchUpInside)
        backButton.imageView?.tintColor = color
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: size.width),
            backButton.heightAnchor.constraint(equalToConstant: size.height)
        ])
        return backButton
    }
    
    static func storeDetailButton (title: String, detail: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = .zero
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle])
        attributedString.append(NSAttributedString(string: "\n\n\(detail)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 14), NSAttributedString.Key.foregroundColor: UIColor.purpleProductTitle]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.contentHorizontalAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.grayBackGround.cgColor
        button.layer.borderWidth = 2
        button.layer.masksToBounds = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        return button
    }
    
}

extension UITextField {
    
    static func searchBar (placeholderText: String, defaultText: String) -> UITextField {
        let searchBar = MyTextField(frame: .zero)
        searchBar.backgroundColor = .white
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowOffset = .zero
        searchBar.layer.shadowOpacity = 0.2
        searchBar.layer.masksToBounds = false
        searchBar.layer.cornerRadius = 15
        searchBar.text = defaultText
        searchBar.textAlignment = .left
        searchBar.textColor = .purpleProductTitle
        searchBar.font = UIFont.gothamBook(size: 14)
        searchBar.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            NSAttributedString.Key.font: UIFont.gothamBook(size: 14),
            NSAttributedString.Key.foregroundColor: UIColor.searchBarPlaceHolder
        ])
        searchBar.textPadding = UIEdgeInsets(top: 2, left: 10, bottom: 0, right: 20)
        let searchIcon = UIImageView(frame: .zero)
        searchIcon.image = UIImage(named: "icon_search")?.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = .purpleNavigationBar
        searchIcon.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            searchIcon.widthAnchor.constraint(equalToConstant: 20),
            searchIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        searchBar.leftViewMode = .always
        searchBar.leftView = searchIcon
        searchBar.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        searchBar.addTarget(UITextField.self, action: #selector(textFieldDidChange), for: .editingChanged)
        return searchBar
    }
    
    @objc static func textFieldDidChange (view: UIView) {
        searchFieldInputText = (view as? UITextField)?.text ?? ""
    }
}

class MyTextField: UITextField {
    var textPadding: UIEdgeInsets?

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        guard let textPadding = self.textPadding else {
            return super.textRect(forBounds: bounds)
        }
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        guard let textPadding = self.textPadding else {
            return super.editingRect(forBounds: bounds)
        }
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
