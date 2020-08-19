//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class StoreProductCell: MyCollectionViewCell {
    
    var productData: ProductViewModel? {
        didSet {
            if let productData = productData {
                print(productData)
                productPhoto.image = UIImage(named: productData.photo)
                let attributedString = NSMutableAttributedString(string: productData.title, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 12), NSAttributedString.Key.foregroundColor: UIColor.purpleProductTitle])
                productLeftTitle.attributedText = attributedString
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .clear
        parentView.translatesAutoresizingMaskIntoConstraints = false
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
            productPhoto.topAnchor.constraint(equalTo: container.topAnchor),
            productPhoto.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            productPhoto.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            productPhoto.widthAnchor.constraint(equalTo: container.widthAnchor),
            productLeftTitle.topAnchor.constraint(equalTo: productPhoto.bottomAnchor),
            productLeftTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            productLeftTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4)
        ])
    }
}


class StoreProductTitle: UICollectionReusableView {
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .purpleHomeTitle
        label.font = UIFont.gothamBold(size: 12)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewMore: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "VER MÁS"
        label.textColor = .grayText
        label.font = .gothamMedium(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(viewMore)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            viewMore.topAnchor.constraint(equalTo: self.topAnchor),
            viewMore.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            viewMore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}


