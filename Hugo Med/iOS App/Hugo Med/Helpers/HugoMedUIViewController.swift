//
//  CustomPageControl.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/28/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import UIKit

class HugoMedUIViewController: UIViewController {
    
    //MARK: NAVIGATION AND UI
    var navBarColor: UIColor = .white
    
    var navBarTintColor: UIColor = .white
    
    var navBarTitle: String? = nil
    
    var navBarTitleImage: String? = nil
    
    let backGroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var constraints: [NSLayoutConstraint] = [
        backGroundImage.widthAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.widthAnchor),
        backGroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
        backGroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ]
    
    
    func setBackground() {
        self.view.backgroundColor = .white
        self.view.addSubview(backGroundImage)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: LIFE CYCLE EVENTS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navBarTitle == nil && navBarTitleImage == nil {
            navigationItem.removeTitleView()
        }
        if let navBarTitle = self.navBarTitleImage {
            navigationItem.addImageTitleViewWith(image: navBarTitle, with: navBarTintColor)
        }
        navigationItem.setTintColors(for: navigationController?.navigationBar, color: navBarColor, itemsColor: navBarTintColor)
    }
    
    // MARK: Orientation Changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // MARK: EVENTS
    
    func addNotificationObserver(selector: Selector) {
       
    }
}

class HugoMedUICollectionViewController: UICollectionViewController {
    
    var navBarColor: UIColor = .white
    
    var navBarTintColor: UIColor = .white
    
    var navBarTitle: String? = nil
    
    var navBarTitleImage: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.isToolbarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if navBarTitle == nil && navBarTitleImage == nil {
            navigationItem.removeTitleView()
        }
        if let navBarTitle = self.navBarTitle {
            navigationItem.title = navBarTitle
        }
        if let navBarTitle = self.navBarTitleImage {
            navigationItem.addImageTitleViewWith(image: navBarTitle, with: navBarTintColor)
        }
        
        navigationItem.setTintColors(for: navigationController?.navigationBar, color: navBarColor, itemsColor: navBarTintColor)
    }
    
}
