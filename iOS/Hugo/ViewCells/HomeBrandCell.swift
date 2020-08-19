//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class HomeBrandCell: MyCollectionViewCell {
    
    var brandData: HomeBrandViewModel? {
        didSet {
            if let brandData = brandData {
                print(brandData)
                brandPhoto.image = UIImage(named: brandData.photo)
                brandIcon.image = UIImage(named: brandData.icon)
                let attributedString = NSMutableAttributedString(string: brandData.name, attributes: [NSAttributedString.Key.font : UIFont.gothamBold(size: 15), NSAttributedString.Key.foregroundColor: UIColor.purpleBrandTitle])
                attributedString.append(NSAttributedString(string: "\n\(brandData.categories)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                brandLeftTitle.attributedText = attributedString
                
                let attributedString2 = NSMutableAttributedString(string: brandData.time, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 12), NSAttributedString.Key.foregroundColor: UIColor.grayText])
                attributedString2.append(NSAttributedString(string: "\n\(brandData.subtext)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 6), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                brandRightTitle.attributedText = attributedString2
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .white
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 8
        parentView.layer.masksToBounds = true
        
        parentView.addSubview(brandPhoto)
        parentView.addSubview(iconView)
        parentView.addSubview(heartButton)
        parentView.addSubview(brandLeftTitle)
        parentView.addSubview(brandRightTitle)
        return parentView
    }()
    
    let brandPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var iconView: UIView = {
        let iconview = UIView()
        iconview.layer.shadowColor = UIColor.black.cgColor
        iconview.layer.shadowRadius = 5
        iconview.layer.shadowOffset = .zero
        iconview.layer.shadowOpacity = 0.2
        iconview.layer.masksToBounds = false
        iconview.translatesAutoresizingMaskIntoConstraints = false
        iconview.addSubview(brandIcon)
        return iconview
    }()
    
    let brandIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heartButton: HeartButton = {
        let button = HeartButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "heart_icon")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .white
        return button
    }()
    
    let brandLeftTitle: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        return label
    }()
    
    let brandRightTitle: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.isEditable = false
        label.isScrollEnabled = false
        return label
    }()
    
    override func addConstraints(_ constraints: [NSLayoutConstraint]) {
        super.addConstraints(constraints)
        //NSLayoutConstraint.activate(constraints)
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(container)
        addConstraints([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            brandPhoto.topAnchor.constraint(equalTo: self.topAnchor),
            brandPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            brandPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            brandPhoto.bottomAnchor.constraint(equalTo: brandLeftTitle.topAnchor),
            heartButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            heartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            heartButton.widthAnchor.constraint(equalToConstant: 30),
            heartButton.heightAnchor.constraint(equalToConstant: 30),
            brandLeftTitle.topAnchor.constraint(equalTo: brandPhoto.bottomAnchor),
            brandLeftTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            brandLeftTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
            brandIcon.topAnchor.constraint(equalTo: iconView.topAnchor),
            brandIcon.bottomAnchor.constraint(equalTo: iconView.bottomAnchor),
            brandIcon.leadingAnchor.constraint(equalTo: iconView.leadingAnchor),
            brandIcon.trailingAnchor.constraint(equalTo: iconView.trailingAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 44),
            iconView.heightAnchor.constraint(equalToConstant: 44),
            iconView.trailingAnchor.constraint(equalTo: brandLeftTitle.leadingAnchor),
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            brandRightTitle.topAnchor.constraint(equalTo: brandLeftTitle.topAnchor),
            brandRightTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
    
    @objc func heartButtonTapped () {
        heartButton.isSelected.toggle()
    }
}

class HeartButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.imageView?.tintColor = .red
            } else {
                self.imageView?.tintColor = .white
            }
        }
    }
}

