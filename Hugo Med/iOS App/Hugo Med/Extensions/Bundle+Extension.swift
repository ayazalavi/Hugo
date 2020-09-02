//
//  NSBundle+Extension.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

extension Bundle {
    /**
     Gets the contents of the specified plist file.
     
     - parameter plistName: property list where defaults are declared
     - returns: dictionary of values
     */
    static func contentsOfFile(plistName: String) -> Data? {
        guard let resourcePath = Bundle.main.path(forResource: plistName, ofType: "plist") else { return nil }
        let contents = try? Data(contentsOf: URL(fileURLWithPath: resourcePath))
        return contents
    }
    
    
}
