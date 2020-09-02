//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class SearchResultFilterCell: MyCollectionViewCell {
    
    var filterData: SearchResultFilterViewModel? {
        didSet {
            if let filterData = filterData {
                print(filterData)
                let attributedString = NSMutableAttributedString(string: filterData.title, attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 10), NSAttributedString.Key.foregroundColor: UIColor.grayText])
                filterTitle.attributedText = attributedString
            }
        }
    }
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .grayBackGround
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 15
        parentView.layer.masksToBounds = true
        parentView.addSubview(filterTitle)
        return parentView
    }()
    
    let filterTitle: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
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
        addConstraints([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            filterTitle.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            filterTitle.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}



