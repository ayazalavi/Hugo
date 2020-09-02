//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class SearchListCell: MyCollectionViewCell {
    
    var searchData: SearchListViewModel? {
        didSet {
            if let searchData = searchData {
                print(searchData)
                searchPhoto.image = UIImage(named: searchData.photo)
                let attributedString = NSMutableAttributedString(string: searchData.title, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 14), NSAttributedString.Key.foregroundColor: UIColor.purpleProductTitle])
                attributedString.append(NSAttributedString(string: "\n\(searchData.subtitle)", attributes: [NSAttributedString.Key.font : UIFont.gothamBook(size: 10), NSAttributedString.Key.foregroundColor: UIColor.grayText]))
                searchTitle.attributedText = attributedString
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .clear
        parentView.layer.shadowColor = UIColor.black.cgColor
        parentView.layer.shadowRadius = 5
        parentView.layer.shadowOffset = .zero
        parentView.layer.shadowOpacity = 0.2
        parentView.layer.masksToBounds = false
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(searchPhoto)
        return parentView
    }()
    
    let searchPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let searchTitle: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = .lightGray
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 2
                self.layer.shadowOffset = CGSize(width: 0, height: 3)
                self.layer.shadowOpacity = 0.4
                self.layer.masksToBounds = false
            }
            else {
                self.backgroundColor = .clear
                self.layer.shadowColor = UIColor.clear.cgColor
                self.layer.shadowRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.masksToBounds = true
            }
        }
    }
    
    override func addConstraints(_ constraints: [NSLayoutConstraint]) {
        super.addConstraints(constraints)
        //NSLayoutConstraint.activate(constraints)
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(container)
        addSubview(searchTitle)
        addConstraints([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            container.widthAnchor.constraint(equalToConstant: 36),
            container.heightAnchor.constraint(equalToConstant: 36),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchPhoto.topAnchor.constraint(equalTo: container.topAnchor),
            searchPhoto.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            searchPhoto.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            searchPhoto.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            searchTitle.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 10),
            searchTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

class SearchTitle: UICollectionReusableView {
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .purpleHomeTitle
        label.font = UIFont.gothamBold(size: 14)
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}


