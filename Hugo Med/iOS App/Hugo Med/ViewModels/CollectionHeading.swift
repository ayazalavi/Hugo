//
//  CollectionHeading.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/29/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import IGListKit

class CollectionHeading: NSObject, ListDiffable {
    
    let title: NSAttributedString
    
    init(title: NSAttributedString) {
        self.title = title
        super.init()
    }
    
    // MARK: ListDiffable Protocol
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
}


// MARK: Page Title IGListSection

class PageHeaderSectionController: ListSectionController {

    private var object: CollectionHeading?
    private var bottomMargin: CGFloat

    required init(bottomMargin: CGFloat) {
        self.bottomMargin = bottomMargin
        super.init()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let height = object?.title.height(withConstrainedWidth: collectionContext?.containerSize.width ?? 237) ?? 20
        return CGSize(width: collectionContext?.containerSize.width ?? 237, height: height + self.bottomMargin)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {

        guard let cell: PageHeaderCell = collectionContext?.dequeueReusableCell(of: PageHeaderCell.self, for: self, at: index) as? PageHeaderCell else {
            fatalError()
        }
        //cell.text = object?.items[index] ?? "undefined"
        cell.data = object
        cell.backgroundColor = .clear
        return cell
    }

    override func didUpdate(to object: Any) {
        self.object = object as? CollectionHeading
    }

    override func didSelectItem(at index: Int) {
        print("title list handler \(index)")
    }
}


fileprivate class PageHeaderCell: UICollectionViewCell, ListBindable {
    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? CollectionHeading else { return }
        data = viewModel
    }
    
    var data: CollectionHeading? {
        didSet {
            guard let data = data else { return }
            text.attributedText = data.title
            text.sizeToFit()
            print(text.bounds)
        }
    }
    
    lazy private var text: UITextView = {
        let textView_ = UITextView.textView()
        textView_.backgroundColor = .clear
        self.contentView.addSubview(textView_)
        return textView_
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        text.frame = contentView.bounds
    }
    
}
