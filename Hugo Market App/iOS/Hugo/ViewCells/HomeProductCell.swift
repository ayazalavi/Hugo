//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class HomeProductCell: MyCollectionViewCell {
    
    var productData: HomeProductViewModel? {
        didSet {
            if let productData = productData {
                print(productData)
                productPhoto.image = UIImage(named: productData.photo)
                let attributedString = NSMutableAttributedString(string: productData.title, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 12), NSAttributedString.Key.foregroundColor: UIColor.purpleProductTitle])
                attributedString.append(NSAttributedString(string: "\n\(productData.subtitle)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.graySubtitle]))
                productLeftTitle.attributedText = attributedString
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .white
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 4
        parentView.layer.masksToBounds = true
        parentView.addSubview(productPhoto)
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
        addConstraints([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productPhoto.topAnchor.constraint(equalTo: self.topAnchor),
            productPhoto.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productPhoto.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productPhoto.bottomAnchor.constraint(equalTo: productLeftTitle.topAnchor),
            productLeftTitle.topAnchor.constraint(equalTo: productPhoto.bottomAnchor),
            productLeftTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            productLeftTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
}



