//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class StoreCell: MyCollectionViewCell {
    
    var storeData: StoreViewModel? {
        didSet {
            if let storeData = storeData {
                print(storeData)
                storePhoto.image = UIImage(named: storeData.photo)
                storeIcon.image = UIImage(named: storeData.icon)
                let attributedString = NSMutableAttributedString(string: storeData.name, attributes: [NSAttributedString.Key.font : UIFont.gothamBold(size: 15), NSAttributedString.Key.foregroundColor: UIColor.purpleBrandTitle])
                attributedString.append(NSAttributedString(string: "\n\(storeData.categories)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                storeLeftTitle.attributedText = attributedString
                
                let attributedString2 = NSMutableAttributedString(string: storeData.time, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 12), NSAttributedString.Key.foregroundColor: UIColor.grayText])
                attributedString2.append(NSAttributedString(string: "\n\(storeData.subtext)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 6), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                storeRightTitle.attributedText = attributedString2
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .white
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 8
        parentView.layer.masksToBounds = true
        parentView.addSubview(storePhoto)
        parentView.addSubview(storeIcon)
        parentView.addSubview(nuevoView)
        parentView.addSubview(storeLeftTitle)
        parentView.addSubview(storeRightTitle)
        return parentView
    }()
    
    let storePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let storeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nuevoView: UILabel = {
        let nuevotext = UILabel(frame: .zero)
        nuevotext.translatesAutoresizingMaskIntoConstraints = false
        nuevotext.text = "NUEVO"
        nuevotext.textAlignment = .center
        nuevotext.textColor = .orange
        nuevotext.font = .gothamMedium(size: 12)
        nuevotext.backgroundColor = .white
        nuevotext.layer.cornerRadius = 2
        nuevotext.layer.masksToBounds = true
        return nuevotext
    }()
    
    let storeLeftTitle: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        return label
    }()
    
    let storeRightTitle: UITextView = {
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
            storePhoto.topAnchor.constraint(equalTo: self.topAnchor),
            storePhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            storePhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            storePhoto.bottomAnchor.constraint(equalTo: storeLeftTitle.topAnchor),
            nuevoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            nuevoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            nuevoView.widthAnchor.constraint(equalToConstant: 68),
            nuevoView.heightAnchor.constraint(equalToConstant: 24),
            storeLeftTitle.topAnchor.constraint(equalTo: storePhoto.bottomAnchor, constant: 10),
            storeLeftTitle.leadingAnchor.constraint(equalTo: storeIcon.trailingAnchor),
            storeLeftTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            storeIcon.topAnchor.constraint(equalTo: storeLeftTitle.topAnchor),
            storeIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            storeIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            storeIcon.trailingAnchor.constraint(equalTo: storeLeftTitle.leadingAnchor),
            storeIcon.widthAnchor.constraint(equalToConstant: 44),
            storeIcon.heightAnchor.constraint(equalToConstant: 44),
            storeRightTitle.topAnchor.constraint(equalTo: storeLeftTitle.topAnchor, constant: 5),
            storeRightTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
    
}

