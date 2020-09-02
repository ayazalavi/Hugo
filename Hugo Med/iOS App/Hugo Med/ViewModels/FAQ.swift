//
//  FAQ.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/31/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import IGListKit

class FAQ: NSObject, ListDiffable {
    
    let shortText: String
    let detailedText: String
    
    init(shortText: String, detailedText: String) {
        self.shortText = shortText
        self.detailedText = detailedText
        super.init()
    }
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return (object is FAQ) && (object as? FAQ)?.shortText == self.shortText && (object as? FAQ)?.detailedText == self.detailedText
    }

}
