//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class HomeStoreCell: MyCollectionViewCell {
    
    var storeData: HomeStoreViewModel? {
        didSet {
            if let storeData = storeData {
                print(storeData)
                storePhoto.image = UIImage(named: storeData.photo)
                let attributedString = NSMutableAttributedString(string: storeData.title, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 10), NSAttributedString.Key.foregroundColor: UIColor.grayText])
                storeTitle.attributedText = attributedString
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.borderColor = UIColor.purpleHomeTitle.cgColor
        parentView.layer.borderWidth = 3
        parentView.layer.cornerRadius = 37
        parentView.layer.masksToBounds = true
        parentView.addSubview(storePhoto)
        return parentView
    }()
    
    let storePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let storeTitle: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
        addSubview(storeTitle)
        addConstraints([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: storeTitle.topAnchor),
            container.widthAnchor.constraint(equalToConstant: 74),
            container.heightAnchor.constraint(equalToConstant: 74),
            storePhoto.topAnchor.constraint(equalTo: container.topAnchor, constant: 7),
            storePhoto.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 7),
            storePhoto.widthAnchor.constraint(equalToConstant: 60),
            storePhoto.heightAnchor.constraint(equalToConstant: 60),
            storeTitle.topAnchor.constraint(equalTo: container.bottomAnchor),
            storeTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            storeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}



