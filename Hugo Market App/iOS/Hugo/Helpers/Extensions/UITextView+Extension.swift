//
//  UITextView+Extension.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
}

extension UIFont {
    
    static func gothamBook (size: CGFloat) -> UIFont {
        UIFont(name: "HomepageBaukasten-Book", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func gothamBold (size: CGFloat) -> UIFont {
        UIFont(name: "HomepageBaukasten-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func gothamUltra (size: CGFloat) -> UIFont {
        UIFont(name: "iCielGotham-Ultra", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func gothamMedium (size: CGFloat) -> UIFont {
        UIFont(name: "iCielGotham-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func gothamBook14 () -> UIFont { UIFont(name: "HomepageBaukasten-Book", size: 14) ?? UIFont.systemFont(ofSize: 14) }
    
    static var gothamBold16: UIFont { UIFont(name: "HomepageBaukasten-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16) }
        
    static var gothamUltra16: UIFont { UIFont(name: "iCielGotham-Ultra", size: 16) ?? UIFont.systemFont(ofSize: 16) }
}

extension UIColor {
    
    static var grayText = UIColor(red: 0.5019607843137255, green: 0.4705882352941176, blue: 0.5490196078431373, alpha: 1.0)
    
    static var purpleNavigationBar = UIColor(red: 0.2196078431372549, green: 0.03921568627450979, blue: 0.3764705882352941, alpha: 1.0)
    
    static var purpleHomeTitle = UIColor(red: 0.3490196078431372, green: 0.1019607843137255, blue: 0.5372549019607843, alpha: 1.0)
    
    static var purpleBrandTitle = UIColor(red: 0.2196078431, green: 0.1098039216, blue: 0.3607843137, alpha: 1.0)
    
    static var purpleProductTitle = UIColor(red: 0.1803921568627451, green: 0.06274509803921569, blue: 0.2823529411764706, alpha: 1.0)
    
    static var graySubtitle = UIColor(red: 0.7490196078431373, green: 0.7333333333333333, blue: 0.7725490196078432, alpha: 1.0)
    
    static var searchBarPlaceHolder = UIColor(red: 0.6588235294117647, green: 0.7294117647058823, blue: 0.7411764705882353, alpha: 1.0)
    
    static var grayBackGround = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
    
    static var purpleFavrito = UIColor(red: 0.514, green: 0.235, blue: 0.722, alpha: 1.0)

}
