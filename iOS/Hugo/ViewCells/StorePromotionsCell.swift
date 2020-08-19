//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class StorePromotionsCell: MyCollectionViewCell {
    
    var promotionData: StorePromotionsViewModel? {
        didSet {
            if let promotionData = promotionData {
                print(promotionData)
                storePhoto.image = UIImage(named: promotionData.photo)
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .clear
        parentView.layer.cornerRadius = 5
        parentView.layer.masksToBounds = true
        parentView.translatesAutoresizingMaskIntoConstraints = false        
        parentView.addSubview(storePhoto)
        return parentView
    }()
    
    let storePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func addConstraints(_ constraints: [NSLayoutConstraint]) {
        super.addConstraints(constraints)
        //NSLayoutConstraint.activate(constraints)
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(storePhoto)
        addConstraints([
            storePhoto.widthAnchor.constraint(equalToConstant: 300),
            storePhoto.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}



