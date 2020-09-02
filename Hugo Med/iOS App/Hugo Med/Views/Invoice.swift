//
//  Invoice.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import IGListKit
 //let text1 = NSMutableAttributedString(string: "Haz pagado", attributes: [NSAttributedString.Key.font: UIFont(name: "GothamHTF-Book", size: 13), NSAttributedString.Key.foregroundColor: UIColor.hexStringToUIColor(hex: "#8777B2")])
class Invoice: HugoMedUIViewController {
    // MARK: DATA
    let nav_bar: Content = String.scanFor(key: .nav_bar)
    let receipt: Receipt

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    var items: [Any] = []
    
    // MARK: UI ELEMENTS
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let background: MyUIView = MyUIView(frame: .zero)
    
    
    // MARK: LIFE CYCLE EVENTS
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarColor = .clear
        navBarTintColor = .white
        navBarTitle = ""
        navBarTitleImage = nil
        self.view.backgroundColor = .clear
        self.view.addSubview(background)
        
        self.items.append(receipt)
        self.items.append(receipt.details)
    
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(popViewController), target: self))
        let attributedString = NSAttributedString(string: nav_bar.text!, attributes: [NSAttributedString.Key.font: nav_bar.getFont(), NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.kern: 1.08])
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 226, height: 15))
        label.attributedText = attributedString
        self.navigationItem.titleView = label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        background.frame = view.bounds
        collectionView.frame = view.bounds
    }
    
    init(receipt: Receipt) {
        self.receipt = receipt
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ACTIONS
    
    @objc func popViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension Invoice: ListAdapterDelegate, ListAdapterDataSource  {
    func listAdapter(_ listAdapter: ListAdapter, willDisplay object: Any, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying object: Any, at index: Int) {
        
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.items as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is Receipt:
            return AmountSectionController()
        default:
            return ReceiptDetailsSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

class MyUIView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let topRect = CGRect(x:0, y:0, width:rect.size.width, height:58*rect.size.height/100);
        // Fill the rectangle with grey
        UIColor.hexStringToUIColor(hex: "#D2B6F0").setFill()
        UIRectFill(topRect)
        let bottomRect = CGRect(x:0, y:58*rect.size.height/100, width:rect.size.width, height:42*rect.size.height/100);
        UIColor.white.setFill()
        UIRectFill(bottomRect)
    }
}
