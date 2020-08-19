//
//  BaseProtocol.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/11/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

protocol _BaseProtocol {
    
}

protocol SearchResultDelegate {
    func searchResultSelectedAtIndex (data: _BaseProtocol)
}

protocol MenuDelegate {
    func menuItemSelected (category: String)
}
