//
//  FAQ.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/31/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit
import IGListKit

class FAQList: HugoMedUIViewController, ListAdapterDataSource, ListAdapterDelegate {
    
    // MARK: DATA
    
    let header = NSMutableAttributedString()
    
    lazy var listTitle = CollectionHeading(title: header)
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    var items: [Any] = []
    
    // MARK: UI ELEMENTS
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: LIFE CYCLE EVENTS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarColor = String.scanFor(key: .nav_bar).getBackgroundColor()
        navBarTintColor = String.scanFor(key: .nav_bar).getTextColor()
        navBarTitle = nil
        navBarTitleImage = nil
        self.setBackground()
        
        header.append(NSAttributedString(string: "Preguntas frecuentes", attributes:
            [NSAttributedString.Key.font: String.scanFor(key: .doctors_collection_title).getFont(), NSAttributedString.Key.foregroundColor: String.scanFor(key: .doctors_collection_title).getTextColor()])
        )
        
        self.items.append(listTitle)
        _ = FAQs.map {
            self.items.append($0)
        }
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.customButton(image: #imageLiteral(resourceName: "back-arrow").withRenderingMode(.alwaysTemplate), tintColor: navBarTintColor, selector: #selector(popViewController), target: self))
        navigationItem.rightBarButtonItem = nil
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 16, y: 0, width: view.bounds.size.width-32, height: view.bounds.height)
    }
    
    // MARK: ACTIONS
    
    @objc func popViewController () {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: LIST ADAPTAR DELEGATE
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return items as! [ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is CollectionHeading:
            return PageHeaderSectionController(bottomMargin: 22)
        default:
            return FAQSectionController()
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willDisplay object: Any, at index: Int) {
        
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying object: Any, at index: Int) {
        
    }
    
    
}

fileprivate class FAQSectionController: ListSectionController {
    
    private var expanded = false
    private var faq: FAQ?
    
    required override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return calculateSizeBy(containerWidth: collectionContext!.containerSize.width, faq: faq ?? FAQ(shortText: "", detailedText: ""), expanded: expanded)
    }
    
    func calculateSizeBy(containerWidth: CGFloat, faq: FAQ, expanded: Bool) -> CGSize {
        let faqHeight = faq.shortText.height(withConstrainedWidth: containerWidth, font: String.scanFor(key: .faq_title).getFont()) + 52
        let detailsHeight = faq.detailedText.height(withConstrainedWidth: containerWidth, font: String.scanFor(key: .faq_description).getFont()) + 38
        let height = expanded ? faqHeight + detailsHeight : faqHeight
        return CGSize(width: containerWidth, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: FAQCell = collectionContext?.dequeueReusableCell(of: FAQCell.self, for: self, at: index) as? FAQCell else {
            fatalError()
        }
        cell.expanded = expanded
        cell.data = faq
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.faq = object as? FAQ
    }
    
    override func didSelectItem(at index: Int) {
        collectionContext?.performBatch(animated: true, updates: { (batchContext) in
            self.expanded.toggle()
            batchContext.reload(self)
        })
    }
}

final class FAQCell: UICollectionViewCell {

    fileprivate let titleInsets = UIEdgeInsets(top: 16, left: 19, bottom: 0, right: 49)
    fileprivate let descriptionInsets = UIEdgeInsets(top: 17, left: 19, bottom: 0, right: 19)
    fileprivate let titleStyle = String.scanFor(key: .faq_title)
    fileprivate let descriptionStyle = String.scanFor(key: .faq_description)
        
    static func calculateSizeBy(_ faq: FAQ, expanded: Bool)  {
        
//        let constrainedSize = CGSize(width: width - titleInsets.left - titleInsets.right, height: CGFloat.greatestFiniteMagnitude)
//        let attributes = [ NSAttributedString.Key.font: titleStyle.getFont() ]
//        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
//        let bounds = (text as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
//        return ceil(bounds.height) + titleInsets.top + titleInsets.bottom
    }
    
    fileprivate lazy var faq: UITextView = {
        let label = UITextView.textView()
        label.backgroundColor = .white
        label.font = self.titleStyle.getFont()
        label.textAlignment = .left
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.contentMode = .center
        label.textColor = self.titleStyle.getTextColor()
        label.isUserInteractionEnabled = false
        label.contentInset = .zero
        label.textContainerInset = titleInsets
        self.addSubview(label)
        return label
    }()
    
    fileprivate lazy var arrow: UIImageView = {
        let imageView = UIImageView.photo(name: "down-arrow")
        imageView.tintColor = self.titleStyle.getTextColor()
        self.addSubview(imageView)
        return imageView
    }()

    fileprivate lazy var details: UITextView = {
        let label = UITextView.textView()
        label.backgroundColor = .clear
        label.font = self.descriptionStyle.getFont()
        label.textAlignment = .left
        label.textColor = self.descriptionStyle.getTextColor()
        label.contentInset = .zero
        label.textContainerInset = self.descriptionInsets
        self.addSubview(label)
        return label
    }()
    
    var expanded: Bool

    var data: FAQ? {
        didSet {
            if let data = data {
                self.faq.text = data.shortText
                self.details.text = data.detailedText
                
            }
        }
    }

    override init(frame: CGRect) {
        expanded = false
        super.init(frame: frame)
        self.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("frame: \(details.frame) bounds: \(details.bounds)")
        details.isHidden = !expanded
        faq.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 83)
        details.frame = CGRect(x: 0, y: 83, width: self.bounds.width, height: 157)
        arrow.frame = CGRect(x: self.bounds.width - 25, y: 41, width: 9, height: 6)
        if expanded {
            self.faq.textColor = .white
            self.faq.backgroundColor = self.titleStyle.getBackgroundColor()
            self.arrow.image = #imageLiteral(resourceName: "down-arrow").rotate(radians: CGFloat(Double.pi)).withRenderingMode(.alwaysTemplate)
            self.arrow.tintColor = .white
        }
        else {
            self.faq.textColor = self.titleStyle.getTextColor()
            self.faq.backgroundColor = .white
            self.arrow.image = #imageLiteral(resourceName: "down-arrow").withRenderingMode(.alwaysTemplate)
            self.arrow.tintColor = self.titleStyle.getTextColor()
        }
        print("frame: \(details.frame) bounds: \(details.bounds)")
        self.details.sizeToFit()
        print("frame: \(details.frame) bounds: \(details.bounds)")
//        let bounds = contentView.bounds
//        label.frame = bounds.inset(by: LabelCell.insets)
//        let height: CGFloat = 0.5
//        let left = LabelCell.insets.left
//        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }
}

extension FAQCell: ListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? FAQ else { return }
        data = viewModel
    }

}

