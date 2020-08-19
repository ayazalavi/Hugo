//
//  SearchResultsViewController.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsViewController: UIViewController, UITextFieldDelegate, SearchResultDelegate {
   
    lazy var content: UIScrollView = {
        let scrollview = UIScrollView(frame: .zero)
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.showsVerticalScrollIndicator = false
        scrollview.addSubview(searchBar)
        scrollview.addSubview(filterCollectionView)
        scrollview.addSubview(storeCollectionView)
        scrollview.addSubview(productCollectionView)
        return scrollview
    }()
    
    lazy var searchBar: UITextField = {
        let textField = UITextField.searchBar(placeholderText: "Hola Ricardo, ¿Qué quieres hoy?", defaultText: searchFieldInputText)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy fileprivate var filterCollectionView: SearchFilterCollectionView = {
        
        let collectionview = SearchFilterCollectionView(frame: .zero, data: productFilterData)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
        
    }()
    
    lazy var storeCollectionView: StoreBrandCollectionView = {
        let collectionview = StoreBrandCollectionView(frame: .zero, data: searchStoreData)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.title.text = "POPULARES"
        collectionview.viewMore.isHidden = true
        collectionview.hideNuevos = true
        collectionview.delegate = self
        return collectionview
    }()
    
    lazy fileprivate var productCollectionView: ProductCollectionView = {
        
        let collectionview = ProductCollectionView(frame: .zero, data: productSearchData, categoryTitle: "PRODUCTOS SUPERMERCADO")
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.viewMore.isHidden = true
        return collectionview
        
    }()
    
    var onBackFromSearchPage: ()->Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frames = [searchBar.frame, filterCollectionView.frame, storeCollectionView.frame, productCollectionView.frame, CGRect(origin: .zero, size:CGSize(width: 0, height: view.safeAreaLayoutGuide.layoutFrame.origin.y))]
        content.computeMainContentHeight(sizes: frames)
        content.contentSize.width = view.frame.width
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func searchResultSelectedAtIndex(data: _BaseProtocol) {
        guard let store = data as? StoreViewModel else {
            print(123)
            return
        }
        let search = StoreHomeViewController()
        search.data = store
        self.navigationController?.pushViewController(search, animated: true)
    }
    
}

extension SearchResultsViewController {
    func setupLayout() {
          
          let barButton1 = UIBarButtonItem(customView: UIButton.closeButton(color: .purpleNavigationBar, selector: #selector(goBack), target: self, size: CGSize(width: 30, height: 30)))
          let centerText = NSMutableAttributedString(string: "RESULTADO DE BÚSQUEDA", attributes: [NSAttributedString.Key.font: UIFont.gothamBold16])
          self.addNavigationBar(leftBarButton: barButton1, centerText: centerText, rightBarButtons: nil)
          
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
              filterCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
              filterCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
              filterCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
              filterCollectionView.heightAnchor.constraint(equalToConstant: 50),
              storeCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 20),
              storeCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
              storeCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
              storeCollectionView.heightAnchor.constraint(equalToConstant: 280),
              productCollectionView.topAnchor.constraint(equalTo: storeCollectionView.bottomAnchor, constant: 20),
              productCollectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
              productCollectionView.widthAnchor.constraint(equalTo: content.widthAnchor),
              productCollectionView.heightAnchor.constraint(equalToConstant: 640)
          ])
      }
    
    @objc func goBack () {
        self.dismiss(animated: false) {
            
        }
    }
}

class SearchFilterCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let data: [SearchResultFilterViewModel]
    
    let cellID = "home-filter-cell"
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(SearchResultFilterCell.self, forCellWithReuseIdentifier: cellID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [SearchResultFilterViewModel]) {
        self.data = data
        super.init(frame: frame)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
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
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultFilterCell
        homeBrandCell.filterData = data[indexPath.item]
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = data[indexPath.item].title
        var size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font : UIFont.gothamMedium(size: 10), NSAttributedString.Key.foregroundColor: UIColor.grayText])
        size.width += 40
        size.height = 35
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

