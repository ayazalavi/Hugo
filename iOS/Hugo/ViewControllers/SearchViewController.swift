//
//  SearchViewController.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, SearchResultDelegate {
    
    lazy var searchBar: UITextField = {
        let textField = UITextField.searchBar(placeholderText: "Hola Ricardo, ¿Qué quieres hoy?", defaultText: searchFieldInputText)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.becomeFirstResponder()
        return textField
    }()
    
    lazy var searchCollectionView: SearchCollectionView = {
        let collectionview = SearchCollectionView(frame: .zero, data: searchListData)
        collectionview.delegate = self
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    var onBackFromSearchPage: ()->Void = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.setNavBarVisibility(value: false)
//        self.view.layer.opacity = 1
//        searchBar.isHidden = false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchCollectionView.data = searchListData
        searchCollectionView.collectionView.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchCollectionView.data = searchresultData
        searchCollectionView.collectionView.reloadData()
        return true
    }
    
    @objc func textFieldDidChange () {
        if searchBar.text == "" {
            searchCollectionView.data = searchListData
            searchCollectionView.collectionView.reloadData()
        }
    }
    
    @objc func goBack () {
//        self.setNavBarVisibility(value: true)
//        self.view.layer.opacity = 0
        self.dismiss(animated: false) {
            self.onBackFromSearchPage()
        }
    }
    
    func searchResultSelectedAtIndex(data: _BaseProtocol) {
        let search = SearchResultsViewController()
        let navigationController = UINavigationController(rootViewController: search)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        search.onBackFromSearchPage = {
            self.searchBar.text = searchFieldInputText
        }
        self.present(navigationController, animated: false) {
            
        }
    }
    
}

extension SearchViewController {
    
    func setupLayout () {
        let barButton1 = UIBarButtonItem(customView: UIButton.backButton(color: .purpleNavigationBar, selector: #selector(goBack), target: self, size: CGSize(width: 30, height: 30)))
        let centerText = NSMutableAttributedString(string: "EXPLORAR", attributes: [NSAttributedString.Key.font: UIFont.gothamBold16])
        self.addNavigationBar(leftBarButton: barButton1, centerText: centerText, rightBarButtons: nil)
       // self.setNavBarVisibility(value: true)
       // self.view.layer.opacity = 0.5
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

class SearchCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data : [[String: Any]]
    
    let cellID = "search-cell"
    
    let sectionID = "search-section"
    
    var delegate: SearchResultDelegate?
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: self.frame.size.width, height: 50)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.register(SearchListCell.self, forCellWithReuseIdentifier: cellID)
        collection.register(SearchTitle.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionID)
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    init(frame: CGRect, data: [[String: Any]]) {
        self.data = data
        super.init(frame: frame)
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let search = self.data[section]["results"] as? [SearchListViewModel] {
            return search.count
        }
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionID, for: indexPath) as! SearchTitle
            sectionHeader.label.text = data[indexPath.section]["category"] as? String
            return sectionHeader
        } else { //No footer in this case but can add option for that
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeBrandCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchListCell
        if let searchData = data[indexPath.section]["results"] as? [SearchListViewModel] {
            homeBrandCell.searchData =  searchData[indexPath.item]
        }
        return homeBrandCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil, let searchData = data[indexPath.section]["results"] as? [SearchListViewModel] {
            delegate?.searchResultSelectedAtIndex(data: searchData[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
//    }
    

    
}



