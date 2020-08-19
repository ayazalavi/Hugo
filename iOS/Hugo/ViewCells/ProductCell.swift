//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: MyCollectionViewCell {
    
    var productData: ProductViewModel? {
        didSet {
            if let productData = productData {
                print(productData)
                productPhoto.image = UIImage(named: productData.photo)
                brandIcon.image = UIImage(named: productData.icon)
                let attributedString = NSMutableAttributedString(string: productData.price, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 12), NSAttributedString.Key.foregroundColor: UIColor.purpleProductTitle])
                attributedString.append(NSAttributedString(string: "\n\(productData.title)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                attributedString.append(NSAttributedString(string: "\n\(productData.subtitle)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 6), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                productLeftTitle.attributedText = attributedString
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .white
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 8
        parentView.layer.masksToBounds = true
        parentView.addSubview(productPhoto)
        return parentView
    }()
    
    lazy var container2: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .clear
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(brandIcon)
        parentView.addSubview(productLeftTitle)
        return parentView
    }()
    
    let productPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let brandIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let productLeftTitle: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
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
        addSubview(container2)
        addConstraints([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: brandIcon.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productPhoto.topAnchor.constraint(equalTo: container.topAnchor),
            productPhoto.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            productPhoto.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            productPhoto.bottomAnchor.constraint(equalTo:container.bottomAnchor),
            container2.topAnchor.constraint(equalTo: container.bottomAnchor),
            container2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            brandIcon.topAnchor.constraint(equalTo: container2.topAnchor),
            brandIcon.leadingAnchor.constraint(equalTo: container2.leadingAnchor, constant: 20),
            brandIcon.widthAnchor.constraint(equalToConstant: 44),
            brandIcon.heightAnchor.constraint(equalToConstant: 44),
            productLeftTitle.topAnchor.constraint(equalTo: brandIcon.topAnchor),
            productLeftTitle.leadingAnchor.constraint(equalTo: brandIcon.trailingAnchor, constant: 5)
        ])
    }
}



