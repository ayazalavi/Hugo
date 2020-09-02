//
//  HomeBrandCell.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class StoreMenuCell: MyCollectionViewCell, MenuDelegate {
    
    var delegate: MenuDelegate?
    
    var categoryTitle: String? {
        didSet {
            if let categoryTitle = categoryTitle {
                print(categoryTitle)
                category.setTitle(categoryTitle, for: .normal)
            }
        }
    }
    
    lazy var bottomLine: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .purpleHomeTitle
        parentView.layer.borderColor = UIColor.purpleHomeTitle.cgColor
        parentView.layer.borderWidth = 2
        parentView.isHidden = true
        parentView.translatesAutoresizingMaskIntoConstraints = false
        return parentView
    }()
    
    lazy var bottomBorder: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .graySubtitle
        parentView.layer.borderColor = UIColor.graySubtitle.cgColor
        parentView.layer.borderWidth = 1
        parentView.isHidden = false
        parentView.translatesAutoresizingMaskIntoConstraints = false
        return parentView
    }()
    
    let category: MenuButton = {
        let button = MenuButton(type: .custom)
        button.backgroundColor = .clear
        button.frame = .zero
        button.contentHorizontalAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.gothamMedium(size: 12)
        button.setTitleColor(.graySubtitle, for: .normal)
        button.setTitleColor(.purpleHomeTitle, for: .highlighted)
        button.setTitleColor(.purpleHomeTitle, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func addConstraints(_ constraints: [NSLayoutConstraint]) {
        super.addConstraints(constraints)
        //NSLayoutConstraint.activate(constraints)
    }
    
    func menuItemSelected(category: String) {
        delegate?.menuItemSelected(category: categoryTitle ?? "")
    }
    
    func makeItemSelected (_ select: Bool) {
        self.category.isSelected = select
        self.bottomLine.isHidden = !select
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(category)
        addSubview(bottomLine)
        addSubview(bottomBorder)
        category.delegate = self
        addConstraints([
            category.topAnchor.constraint(equalTo: self.topAnchor),
            category.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            category.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomLine.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 2),
            bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomLine.heightAnchor.constraint(equalToConstant: 2),
            bottomBorder.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 2),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
}

class MenuButton: UIButton {
    
    var delegate: MenuDelegate?
    
    override var isHighlighted: Bool {
        didSet {
            if !isHighlighted {
                delegate?.menuItemSelected(category: "")
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
               
            }
        }
    }
}




