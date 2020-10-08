//
//  StoreHomeViewController.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class StoreHomeViewController: UIViewController {
    
    var data: StoreViewModel!
    
    var storeCollection = [StoreProductCollectionView]()
    
    private lazy var content: UIScrollView = {
        let scrollview = UIScrollView(frame: .zero)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.addSubview(self.topView)
        scrollview.addSubview(self.storeDetails)
        scrollview.addSubview(self.promotionCollectionView)
        scrollview.addSubview(menuCollectionView)
        scrollview.delegate = self
        return scrollview
    }()
    
    lazy var topView: UIView = {
        let view_ = UIView(frame: .zero)
        view_.translatesAutoresizingMaskIntoConstraints = false
        view_.addSubview(self.banner)
        view_.addSubview(self.icon)
        view_.addSubview(self.searchButton)
        view_.addSubview(self.backButton)
        view_.addSubview(self.storeLeftTitle)
        view_.addSubview(self.favritoButton)
        return view_
    }()
    
    lazy var banner: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: data.photo)
        return imageView
    }()
    
    lazy var icon: UIView = {
        let iconview = UIView()
        iconview.backgroundColor = .clear
        iconview.layer.shadowColor = UIColor.black.cgColor
        iconview.layer.shadowRadius = 2
        iconview.layer.shadowOffset = .zero
        iconview.layer.shadowOpacity = 0.5
        iconview.layer.masksToBounds = false
        iconview.translatesAutoresizingMaskIntoConstraints = false
        iconview.addSubview(imageView)
        return iconview
    }()
    
    lazy var imageView: UIImageView = {
        let iconview = UIImageView()
        iconview.layer.cornerRadius = 30
        iconview.layer.masksToBounds = true
        iconview.contentMode = .scaleAspectFit
        iconview.translatesAutoresizingMaskIntoConstraints = false
        iconview.image = UIImage(named: data.icon)
        return iconview
    }()
    
    lazy var searchButton: UIImageView = {
        let searchButton = UIImageView()
        searchButton.frame = .zero
        searchButton.image = UIImage(named: "icon_search")?.withRenderingMode(.alwaysTemplate)
        searchButton.tintColor = .white
        searchButton.contentMode = .scaleAspectFit
        searchButton.layer.masksToBounds = true
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        return searchButton
    }()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.frame = .zero
        backButton.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        backButton.setImage(UIImage(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .selected)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.imageView?.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    lazy var favritoButton: UIButton = {
        
        let favrito = UIButton(type: .custom)
        favrito.frame = .zero
        favrito.setAttributedTitle(NSAttributedString(string: "FAVORITO", attributes: [NSAttributedString.Key.font: UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        favrito.setAttributedTitle(NSAttributedString(string: "FAVORITO", attributes: [NSAttributedString.Key.font: UIFont.gothamMedium(size: 9), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .highlighted)
        favrito.contentHorizontalAlignment = .left
        favrito.setImage(UIImage(named: "icon_heart_filled")?.withTintColor(.white, renderingMode: .alwaysTemplate), for: .normal)
        favrito.setImage(UIImage(named: "icon_heart_filled")?.withTintColor(.white, renderingMode: .alwaysTemplate), for: .highlighted)
        favrito.setImage(UIImage(named: "icon_heart_filled")?.withTintColor(.white, renderingMode: .alwaysTemplate), for: .selected)
        //print(rightBarButton.imageEdgeInsets, rightBarButton.titleEdgeInsets, rightBarButton.alignmentRectInsets, rightBarButton.contentEdgeInsets)
        favrito.imageEdgeInsets = UIEdgeInsets(top: 8, left: -10, bottom: 8, right: 0)
        favrito.titleEdgeInsets = UIEdgeInsets(top: 2, left: -15, bottom: 0, right: 0)
        favrito.imageView?.tintColor = .white
        favrito.layer.cornerRadius = 5
        favrito.layer.masksToBounds = true
        favrito.translatesAutoresizingMaskIntoConstraints = false
        favrito.backgroundColor = .purpleFavrito
        favrito.imageView?.contentMode = .scaleAspectFit
        favrito.imageView?.frame.size = CGSize(width: 7, height: 7)
        favrito.sizeToFit()
        return favrito
    }()
    
    lazy var storeLeftTitle: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        let attributedString = NSMutableAttributedString(string: data.name, attributes: [NSAttributedString.Key.font : UIFont.gothamBold(size: 24), NSAttributedString.Key.foregroundColor: UIColor.purpleBrandTitle])
        attributedString.append(NSAttributedString(string: "\n\(data.categories)", attributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 12), NSAttributedString.Key.foregroundColor: UIColor.purpleNavigationBar]))
        label.attributedText = attributedString
        return label
    }()
    
    lazy var storeDetails: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        let buttone1 = UIButton.storeDetailButton(title: "DELIVERY", detail: data.time)
        let buttone2 = UIButton.storeDetailButton(title: "HORARIO", detail: data.openTimings)
        let buttone3 = UIButton.storeDetailButton(title: "Rating", detail: String("✭\(data.ratings)"))
        stack.addArrangedSubview(buttone1)
        stack.addArrangedSubview(buttone2)
        stack.addArrangedSubview(buttone3)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var promotionCollectionView: PromotionCollectionView = {
        let promotion = PromotionCollectionView(frame: .zero, data: promotionsData)
        promotion.translatesAutoresizingMaskIntoConstraints = false
        return promotion
    }()
    
    lazy var menuCollectionView: MenuCollectionView = {
        let promotion = MenuCollectionView(frame: .zero, data: storeData)
        promotion.translatesAutoresizingMaskIntoConstraints = false
        promotion.delegate = self
        promotion.backgroundColor = .white
        return promotion
    }()
    
    lazy var storeProductCollectionView: StoreProductCollectionView = {
        let promotion = StoreProductCollectionView(frame: .zero, data: productStoreData)
        promotion.translatesAutoresizingMaskIntoConstraints = false
        return promotion
    }()
    
    var menuTopConstraint, productsTopConstraint: NSLayoutConstraint?
    var menuCollectiontop: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frames = [topView.frame, storeDetails.frame, promotionCollectionView.frame, menuCollectionView.frame, CGRect(origin: .zero, size:CGSize(width: 0, height: view.safeAreaLayoutGuide.layoutFrame.origin.y))]
        let _ = storeCollection.map { frames.append($0.frame) }
        self.content.computeMainContentHeight(sizes: frames)
        content.contentSize.width = view.frame.width
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setNavBarVisibility(value: false)
    }
    
    @objc func goBack () {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension StoreHomeViewController: MenuDelegate {
    func menuItemSelected(category: String) {
        for collection in storeCollection {
            if category == collection.title.text {
                content.scrollRectToVisible(collection.frame, animated: true)
            }
            
        }
    }
    
    func setupLayout() {
        self.setNavBarVisibility(value: true)
        let barButton1 = UIBarButtonItem(customView: UIButton.backButton(color: .purpleNavigationBar, selector: #selector(goBack), target: self, size: CGSize(width: 30, height: 30)))
        let centerText = NSMutableAttributedString(string: data.name.uppercased(), attributes: [NSAttributedString.Key.font: UIFont.gothamBold16])
        let barButton2 = UIBarButtonItem(customView: UIButton.searchButton(color: .purpleNavigationBar, selector: #selector(goBack), target: self, size: CGSize(width: 30, height: 30)))
        self.setNavigationBar(leftBarButton: barButton1, centerText: centerText, rightBarButtons: [barButton2])
        view.addSubview(self.content)
        
        for index in 0..<storeData.count {
            let promotion = StoreProductCollectionView(frame: .zero, data: productStoreData)
            promotion.title.text = storeData[index]["category"] as? String
            promotion.translatesAutoresizingMaskIntoConstraints = false
            self.storeCollection.append(promotion)
            content.addSubview(promotion)
            switch index {
            case 0:
                NSLayoutConstraint.activate([
                    promotion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    promotion.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -10),
                    promotion.heightAnchor.constraint(equalToConstant:  290)
                ])
                productsTopConstraint = promotion.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor, constant: 20)
                productsTopConstraint?.isActive = true
            default:
                NSLayoutConstraint.activate([
                    promotion.topAnchor.constraint(equalTo: storeCollection[index-1].bottomAnchor, constant: 20),
                    promotion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    promotion.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -10),
                    promotion.heightAnchor.constraint(equalToConstant:  290)
                ])
            }
            
        }
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            content.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.topAnchor.constraint(equalTo: content.topAnchor),
            topView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 250),
            banner.topAnchor.constraint(equalTo: topView.topAnchor),
            banner.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -60),
            banner.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            icon.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -30),
            icon.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: 60),
            icon.heightAnchor.constraint(equalToConstant: 60),
            imageView.topAnchor.constraint(equalTo: icon.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: icon.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: icon.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: icon.trailingAnchor),
            searchButton.topAnchor.constraint(equalTo: content.topAnchor, constant: 15),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15),
            backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            storeLeftTitle.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            storeLeftTitle.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            storeLeftTitle.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            favritoButton.topAnchor.constraint(equalTo: storeLeftTitle.topAnchor),
            favritoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            favritoButton.widthAnchor.constraint(equalToConstant: 100),
            favritoButton.heightAnchor.constraint(equalToConstant: 30),
            storeDetails.topAnchor.constraint(equalTo: storeLeftTitle.bottomAnchor, constant: 20),
            storeDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            storeDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            promotionCollectionView.topAnchor.constraint(equalTo: storeDetails.bottomAnchor, constant: 20),
            promotionCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            promotionCollectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -10),
            promotionCollectionView.heightAnchor.constraint(equalToConstant: 220),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            menuCollectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -10),
            menuCollectionView.heightAnchor.constraint(equalToConstant: 50)//CGFloat(storeData.count * 250 + (storeData.count - 1)*20))
        ])
        
        menuTopConstraint = menuCollectionView.topAnchor.constraint(equalTo: promotionCollectionView.bottomAnchor, constant: 20)
        menuTopConstraint?.isActive = true
        self.content.bringSubviewToFront(self.menuCollectionView)
        menuCollectiontop = self.menuCollectionView.frame.origin.y
    }

}

extension StoreHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let menuCollectiontop = menuCollectiontop, menuCollectiontop > 0 else {
            self.menuCollectiontop = self.menuCollectionView.frame.origin.y
            return
        }
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        print(scrollView.contentOffset.y + statusBarHeight, menuCollectiontop + statusBarHeight, statusBarSize, self.view.safeAreaInsets.top)
        if scrollView.contentOffset.y > 280 {
            if let hidden = self.navigationController?.navigationBar.isHidden, hidden {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
        else {
            if let hidden = self.navigationController?.navigationBar.isHidden, !hidden {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
        
        if scrollView.contentOffset.y + statusBarHeight > menuCollectiontop + statusBarHeight {
            for (index, store) in self.storeCollection.enumerated() {
                if store.frame.origin.y > self.content.contentOffset.y {
                    self.menuCollectionView.collectionView.visibleCells.forEach { (cell) in
                        guard let cell_ = cell as? StoreMenuCell else {
                            return
                        }
                        cell_.makeItemSelected(false)
                        cell_.category.isSelected = false
                    }
                    self.menuCollectionView.collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .left)
                    let cell = self.menuCollectionView.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! StoreMenuCell
                    cell.makeItemSelected(true)
                    cell.category.isSelected = true
                    break;
                }
            }
           // print(self.menuCollectiontop ?? 0 + self.menuCollectionView.frame.size.height, self.content.contentOffset)
            if let topC = menuTopConstraint?.constant, topC > 0 {
                menuTopConstraint?.isActive = false
                menuTopConstraint = menuCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
                menuTopConstraint?.isActive = true
                productsTopConstraint?.isActive = false
                productsTopConstraint = self.storeCollection[0].topAnchor.constraint(equalTo: promotionCollectionView.bottomAnchor, constant: 20+menuCollectionView.frame.size.height)
                productsTopConstraint?.isActive = true
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                    self.view.layoutIfNeeded()
                } completion: { (bool) in
                    
                }
            }
        }
        else {
           // print("I am here 1")
            if let topC = menuTopConstraint?.constant, topC == 0 {
              //  print("I am here 2")
                menuTopConstraint?.isActive = false
                menuTopConstraint = menuCollectionView.topAnchor.constraint(equalTo: promotionCollectionView.bottomAnchor, constant: 20)
                menuTopConstraint?.isActive = true
                productsTopConstraint?.isActive = false
                productsTopConstraint = self.storeCollection[0].topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor, constant: 20)
                productsTopConstraint?.isActive = true
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                    self.view.layoutIfNeeded()
                } completion: { (bool) in
                    
                }
            }
        }
    }
}


class PromotionCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [StorePromotionsViewModel]
    
    let cellID = "store-promotions-cell"
    
    let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "PROMOCIONES"
        label.textColor = .purpleHomeTitle
        label.font = .gothamBold(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(StorePromotionsCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [StorePromotionsViewModel]) {
        self.data = data
        super.init(frame: frame)
        addSubview(title)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: title.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StorePromotionsCell
        homeBrandCell.promotionData = data[indexPath.item]
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}


class MenuCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MenuDelegate {
    
    let data: [[String: Any]]
    
    let categories: [String]
    
    let cellID = "store-menu-cell"
    
    var homeBrandCell: StoreMenuCell!
    
    var selectedCategory: String = ""
    
    var delegate: MenuDelegate?
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(StoreMenuCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [[String: Any]]) {
        self.data = data
        categories = data.map({ (dict) -> String in
            if let category = dict["category"] as? String {
                return category
            }
            return ""
        })
        super.init(frame: frame)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func menuItemSelected(category: String) {
        selectedCategory = category
        collectionView.reloadData()
        delegate?.menuItemSelected(category: category)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? StoreMenuCell
        homeBrandCell.categoryTitle = categories[indexPath.item]
        homeBrandCell.delegate = self
        homeBrandCell.makeItemSelected(categories[indexPath.item] == selectedCategory || (indexPath.item == 0 && selectedCategory == ""))
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = (categories[indexPath.item] as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.gothamMedium(size: 12)])
        size.width += 20
        size.height += 10
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}


class StoreProductCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    var data : [ProductViewModel]
    
    let cellID = "product-cell"
    
    let sectionID = "product-section"
    
    var delegate: SearchResultDelegate?
    
    //var collectionView = [UICollectionView]()
    
    let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "SUMMER PRODUCTS"
        label.textColor = .purpleHomeTitle
        label.font = .gothamBold(size: 14)
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
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        //flowLayout.headerReferenceSize = CGSize(width: self.frame.size.width, height: 20)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(StoreProductCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [ProductViewModel]) {
          self.data = data
          super.init(frame: frame)
          addSubview(title)
          addSubview(viewMore)
          addSubview(collectionView)
          NSLayoutConstraint.activate([
              title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
              title.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
              title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
              title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              viewMore.topAnchor.constraint(equalTo: title.topAnchor),
              viewMore.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
              viewMore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
              collectionView.topAnchor.constraint(equalTo: title.bottomAnchor),
              collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
              collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
          ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StoreProductCell
        homeBrandCell.productData = data[indexPath.item]
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 130, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom:0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        if let search = self.data[collectionView.tag]["products"] as? [ProductViewModel] {
//            print(search.count)
//            return search.count
//        }
//        return 0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: self.frame.width, height: 20)
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionID, for: indexPath) as!  StoreProductTitle
//            sectionHeader.label.text = data[collectionView.tag]["category"] as? String
//            return sectionHeader
//        } else { //No footer in this case but can add option for that
//            return UICollectionReusableView()
//        }
//    }
    
}






