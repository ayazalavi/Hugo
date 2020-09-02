//
//  HomeViewController.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit


class HomeViewController: UIViewController, UITextFieldDelegate {
    
    lazy var content: UIScrollView = {
        let scrollview = UIScrollView(frame: .zero)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.addSubview(searchBar)
        scrollview.addSubview(bannerView)
        scrollview.addSubview(brandCollectionView)
        scrollview.addSubview(productCollectionView)
        scrollview.addSubview(storeCollectionView)
        scrollview.addSubview(storeBrandCollectionView)
        let _ = productCategoriesCollectionView.map { scrollview.addSubview($0) }
        return scrollview
    }()
    
    lazy var searchBar: UITextField = {
        let textField = UITextField.searchBar(placeholderText: "Hola Ricardo, ¿Qué quieres hoy?", defaultText: "")
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var bannerView: BannerView = {
        let banner = BannerView(frame: .zero, data: homeBannerData)
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    
    lazy var brandCollectionView: BrandCollectionView = {
        let collectionview = BrandCollectionView(frame: .zero, data: homeBrandData)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var productCollectionView: BrandProductCollectionView = {
        let collectionview = BrandProductCollectionView(frame: .zero, data: homeProductData)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var storeCollectionView: StoreCollectionView = {
        let collectionview = StoreCollectionView(frame: .zero, data: homeStoreData)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var storeBrandCollectionView: StoreBrandCollectionView = {
        let collectionview = StoreBrandCollectionView(frame: .zero, data: homeStoreBrandData)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy fileprivate var productCategoriesCollectionView: [ProductCollectionView] = {
        
        let productCollectionViews: [ProductCollectionView] = productCategoryData.map { (dict) -> ProductCollectionView in
            if dict["products"] is [ProductViewModel], dict["category"] is String {
                let collectionview = ProductCollectionView(frame: .zero, data: dict["products"] as! [ProductViewModel], categoryTitle: dict["category"] as! String)
                collectionview.translatesAutoresizingMaskIntoConstraints = false
                return collectionview
            }
            return ProductCollectionView(frame: .zero, data: [], categoryTitle: "")
        }
        
        return productCollectionViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        /*for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }*/
       // addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frames = [searchBar.frame, bannerView.frame, brandCollectionView.frame, productCollectionView.frame, storeCollectionView.frame, storeBrandCollectionView.frame, CGRect(origin: .zero, size:CGSize(width: 0, height: view.safeAreaLayoutGuide.layoutFrame.origin.y))]
        let _ = productCategoriesCollectionView.map { frames.append($0.frame) }
        content.computeMainContentHeight(sizes: frames)
        content.contentSize.width = view.frame.width
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        gotoSearchViewController()
        return false
    }
    
    @objc func gotoSearchViewController () {
        let search = SearchViewController()
        let navigationController = UINavigationController(rootViewController: search)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        search.onBackFromSearchPage = {
            self.searchBar.text = searchFieldInputText
        }
        self.present(navigationController, animated: false) {
            
        }
    }
    
}

extension HomeViewController {
    
    func setupLayout() {
        
        let rightBarButton = UIButton(type: .custom)
        rightBarButton.frame = .zero
        rightBarButton.setAttributedTitle(NSAttributedString(string: "Oficina", attributes: [NSAttributedString.Key.font: UIFont.gothamBook(size: 12), NSAttributedString.Key.foregroundColor: UIColor.grayText]), for: .normal)
        rightBarButton.setAttributedTitle(NSAttributedString(string: "Oficina", attributes: [NSAttributedString.Key.font: UIFont.gothamBook(size: 12), NSAttributedString.Key.foregroundColor: UIColor.grayText]), for: .highlighted)
        rightBarButton.contentHorizontalAlignment = .left
        rightBarButton.setImage(UIImage(named: "oficina")?.withTintColor(.grayText, renderingMode: .alwaysTemplate), for: .normal)
        rightBarButton.setImage(UIImage(named: "oficina")?.withTintColor(.grayText, renderingMode: .alwaysTemplate), for: .highlighted)
        rightBarButton.setImage(UIImage(named: "oficina")?.withTintColor(.grayText, renderingMode: .alwaysTemplate), for: .selected)
        print(rightBarButton.imageEdgeInsets, rightBarButton.titleEdgeInsets, rightBarButton.alignmentRectInsets, rightBarButton.contentEdgeInsets)
        rightBarButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        rightBarButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        rightBarButton.imageView?.tintColor = .grayText
        
        let barButton2 = UIBarButtonItem(customView: rightBarButton)
        let centerText = NSMutableAttributedString(string: "hugo", attributes: [NSAttributedString.Key.font: UIFont.gothamUltra(size: 18)])
        
        self.addNavigationBar(leftBarButton: nil, centerText: centerText, rightBarButtons: [barButton2])
        
        view.addSubview(content)
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            content.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: content.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10),
            searchBar.widthAnchor.constraint(equalTo: content.widthAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            bannerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            bannerView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 10),
            bannerView.widthAnchor.constraint(equalTo: content.widthAnchor, constant: -20),
            bannerView.heightAnchor.constraint(equalToConstant: 180),
            brandCollectionView.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 20),
            brandCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            brandCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
            brandCollectionView.heightAnchor.constraint(equalToConstant: 280),
            productCollectionView.topAnchor.constraint(equalTo: brandCollectionView.bottomAnchor, constant: 20),
            productCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            productCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
            productCollectionView.heightAnchor.constraint(equalToConstant: 332),
            storeCollectionView.topAnchor.constraint(equalTo: productCollectionView.bottomAnchor, constant: 20),
            storeCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            storeCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
            storeCollectionView.heightAnchor.constraint(equalToConstant: 140),            
            storeBrandCollectionView.topAnchor.constraint(equalTo: storeCollectionView.bottomAnchor, constant: 20),
            storeBrandCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            storeBrandCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
            storeBrandCollectionView.heightAnchor.constraint(equalToConstant: 280)
        ])
        for index in 0..<productCategoriesCollectionView.count {
            NSLayoutConstraint.activate([
                productCategoriesCollectionView[index].topAnchor.constraint(equalTo: (index == 0 ? storeBrandCollectionView.bottomAnchor : productCategoriesCollectionView[index-1].bottomAnchor), constant: 20),
                productCategoriesCollectionView[index].leadingAnchor.constraint(equalTo: content.leadingAnchor),
                productCategoriesCollectionView[index].widthAnchor.constraint(equalTo: content.widthAnchor),
                productCategoriesCollectionView[index].heightAnchor.constraint(equalToConstant: 640)
            ])
        }
    }

}

class BannerView: UIView {
    
    let data: HomeBannerViewModel
    
    lazy var container: UIView = {
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = .clear
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.layer.cornerRadius = 8
        parentView.layer.masksToBounds = true
        parentView.addSubview(banner)
        parentView.addSubview(title)
        return parentView
    }()
    
    let title: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.isEditable = false
        label.isScrollEnabled = false
        
        return label
    }()
    
    let banner: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    init(frame: CGRect, data: HomeBannerViewModel) {
        self.data = data
        super.init(frame: frame)
        let attributedString2 = NSMutableAttributedString(string: data.title, attributes: [NSAttributedString.Key.font : UIFont.gothamBold(size: 28), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedString2.append(NSAttributedString(string: "\n\(data.subtitle)", attributes: [NSAttributedString.Key.font : UIFont.gothamBook(size: 12), NSAttributedString.Key.foregroundColor: UIColor.white]))
        self.title.attributedText = attributedString2
        self.banner.image = UIImage(named: data.photo)
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            banner.topAnchor.constraint(equalTo: container.topAnchor),
            banner.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            banner.widthAnchor.constraint(equalTo: container.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BrandCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [HomeBrandViewModel]
    
    let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "DESTACADOS EN LIFESTYLE"
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
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(HomeBrandCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let cellID = "home-brand-cell"
    
    init(frame: CGRect, data: [HomeBrandViewModel]) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeBrandCell
        homeBrandCell.brandData = data[indexPath.item]
        homeBrandCell.heartButton.addTarget(homeBrandCell, action: #selector(HomeBrandCell.heartButtonTapped), for: .touchUpInside)
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class BrandProductCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [HomeProductViewModel]
    
    let cellID = "home-brand-product-cell"
    
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
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(HomeProductCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [HomeProductViewModel]) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeProductCell
        homeBrandCell.productData = data[indexPath.item]
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 292)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class StoreCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [HomeStoreViewModel]
    
    let cellID = "home-store-cell"
    
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
        collection.register(HomeStoreCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [HomeStoreViewModel]) {
        self.data = data
        super.init(frame: frame)
        addSubview(title)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            title.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
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
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeStoreCell
        homeBrandCell.storeData = data[indexPath.item]
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 74, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class StoreBrandCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [StoreViewModel]
    
    var delegate: SearchResultDelegate?
    
    let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "NUEVOS RESTAURANTES"
        label.textColor = .purpleHomeTitle
        label.font = .gothamBold(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var hideNuevos = false
    
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
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(StoreCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    let cellID = "home-store-product-cell"
    
    init(frame: CGRect, data: [StoreViewModel]) {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! StoreCell
        homeBrandCell.storeData = data[indexPath.item]
        homeBrandCell.nuevoView.isHidden = hideNuevos
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.searchResultSelectedAtIndex(data: data[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

class ProductCollectionView: UIView {
    
    let data: [ProductViewModel]
    
    var categoryTitle: String
    
    lazy var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = self.categoryTitle
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
    
    lazy var collectionView: UIView = {
        let collection = UIView(frame: .zero)
        collection.translatesAutoresizingMaskIntoConstraints = false
        for index in 0..<data.count {
            let productCell = ProductCell(frame: .zero)
            productCell.translatesAutoresizingMaskIntoConstraints = false
            productCell.productData = data[index]
            collection.addSubview(productCell)
        }
        return collection
    }()
    
    init(frame: CGRect, data: [ProductViewModel], categoryTitle: String) {
        self.data = data
        self.categoryTitle = categoryTitle
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
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        for index in 0..<collectionView.subviews.count {
            switch index {
                case 0:
                    NSLayoutConstraint.activate([
                        collectionView.subviews[index].topAnchor.constraint(equalTo: collectionView.topAnchor),
                        collectionView.subviews[index].leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                        collectionView.subviews[index].widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5),
                        collectionView.subviews[index].heightAnchor.constraint(equalToConstant: 260)
                    ])
                case 1:
                    NSLayoutConstraint.activate([
                        collectionView.subviews[index].topAnchor.constraint(equalTo: collectionView.subviews[index-1].bottomAnchor, constant: 50),
                        collectionView.subviews[index].leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                        collectionView.subviews[index].widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5),
                        collectionView.subviews[index].heightAnchor.constraint(equalToConstant: 260)
                    ])
                case 2:
                    NSLayoutConstraint.activate([
                        collectionView.subviews[index].topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 10),
                        collectionView.subviews[index].leadingAnchor.constraint(equalTo: collectionView.subviews[index-2].trailingAnchor),
                        collectionView.subviews[index].widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5),
                        collectionView.subviews[index].heightAnchor.constraint(equalToConstant: 260)
                    ])
                default:
                    NSLayoutConstraint.activate([
                        collectionView.subviews[index].topAnchor.constraint(equalTo: collectionView.subviews[index-1].bottomAnchor, constant: 50),
                        collectionView.subviews[index].leadingAnchor.constraint(equalTo: collectionView.subviews[index-2].trailingAnchor),
                        collectionView.subviews[index].widthAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5),
                        collectionView.subviews[index].heightAnchor.constraint(equalToConstant: 260)
                    ])
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
