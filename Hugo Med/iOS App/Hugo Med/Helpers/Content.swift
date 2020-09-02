//
//  Constants.swift
//  Hugo Med
//
//  Created by Miranz  Technologies on 8/27/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation
import UIKit

var AppSettings = Bundle.contentsOfFile(plistName: ContentKeys.AppSettings.rawValue)

struct Content: Decodable {
    
    let attributedStyle, style, text: String?
    
    enum ContentError: Error {
        case invalid
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ContentKeys.self)
        let key = Array(decoder.userInfo.keys)[0]
        let contentKey = ContentKeys(rawValue: key.rawValue) ?? ContentKeys.welcome_title_1
        let additionalInfo = try values.nestedContainer(keyedBy: ContentStyleCodingKeys.self, forKey: contentKey)
        self.attributedStyle = try? additionalInfo.decode(String.self, forKey: ContentStyleCodingKeys.attributedStyle)
        self.style = try? additionalInfo.decode(String.self, forKey: ContentStyleCodingKeys.style)
        self.text = try? additionalInfo.decode(String.self, forKey: ContentStyleCodingKeys.text)
    }
    
    init(attributedStyle: String, style: String, text: String) {
        self.attributedStyle = attributedStyle
        self.style = style
        self.text = text
    }
    
    func getFont() -> UIFont {
        guard let style = self.style else {
            return UIFont.defaultFont
        }
        let fontDetails = style.components(separatedBy: ",")
       
        let (fontName, size, _) = (fontDetails[0], fontDetails[1].floatValue, fontDetails[3].floatValue)
       // print(fontName, size)
        let font = UIFont(name: fontName, size: CGFloat(size)) ?? UIFont.defaultFont
        return font
    }
    
    func getFontSize() -> Double {
        guard let style = self.style else {
            return 10
        }
        let fontDetails = style.components(separatedBy: ",")
        let size = fontDetails[1].doubleValue
        return size
    }
    
    
    func getTextColor() -> UIColor {
        guard let style = self.style else {
            return UIColor.green
        }
        let fontDetails = style.components(separatedBy: ",")
        let hexString = fontDetails[2]
        return UIColor.hexStringToUIColor(hex: hexString)
    }
    
    func getRadius() -> Double {
        guard let style = self.style else {
            return 0
        }
        let fontDetails = style.components(separatedBy: ",")
        return fontDetails[3].doubleValue
    }
    
    func getBackgroundColor() -> UIColor {
        guard let style = self.style else {
            return UIColor.green
        }
        let fontDetails = style.components(separatedBy: ",")
        let hexString = fontDetails[4]
        return UIColor.hexStringToUIColor(hex: hexString)
    }
    
    func getBorders() -> (UIColor, Double) {
        guard let style = self.style else {
            return (.clear, 0)
        }
        let fontDetails = style.components(separatedBy: ",")
        return (UIColor.hexStringToUIColor(hex: fontDetails[5]), fontDetails[6].doubleValue)
    }
    
    func getAttributedText(alignment: NSTextAlignment) -> NSAttributedString {
        guard let attributedStyle = self.attributedStyle, let text = self.text else {
            return NSAttributedString(string: "EMPTY STRING")
        }
        let attributes = attributedStyle.components(separatedBy: ",")
        let (fontName, startingIndex, length) = (attributes[0], attributes[1].intValue, attributes[2].intValue)
        
        let start, end: Int32
        switch (startingIndex, length) {
            case let (x, y) where x < 0 && y == 0:
                start = Int32(text.count) + x
                end = Int32(text.count)
            case let (x, y) where x < 0 && y > 0:
                start = Int32(text.count) + x
                end = start+y
            case let (x, y) where x >= 0 && y > 0:
                start = x
                end = x+y
            case (_, _):
                start = 0
                end = 0
        }
        
        let index2 = text.index(text.startIndex, offsetBy: Int(start))
        let index3 = text.index(text.startIndex, offsetBy: Int(end))

        let text1 = text.prefix(Int(start))
        let text2 = text[index2..<index3]
        let text3 = text[index3..<text.endIndex]
        let font = UIFont(name: fontName, size: CGFloat(getFontSize())) ?? UIFont.defaultFont
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = alignment
        let attributed = NSMutableAttributedString(string:String(text1), attributes: [NSAttributedString.Key.font: getFont(), NSAttributedString.Key.foregroundColor: getTextColor()])
        attributed.append(NSAttributedString(string:String(text2), attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: getTextColor()]))
        attributed.append(NSAttributedString(string:String(text3), attributes: [NSAttributedString.Key.font: getFont(), NSAttributedString.Key.foregroundColor: getTextColor()]))
        attributed.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphstyle, range: NSRange(location: 0, length: text.count))
        return attributed
    }
    
    func getAttributedTextColor() -> UIColor? {
        guard let attributedStyle = self.attributedStyle else {
            return nil
        }
        let fontDetails = attributedStyle.components(separatedBy: ",")
        guard fontDetails.count > 4 else {
            return nil
        }
        let hexString = fontDetails[4]
        return UIColor.hexStringToUIColor(hex: hexString)
    }
    
    func getAttributedText(alignment: NSTextAlignment, for text: String) -> NSAttributedString {
           guard let attributedStyle = self.attributedStyle else {
               return NSAttributedString(string: "EMPTY STRING")
           }
           let attributes = attributedStyle.components(separatedBy: ",")
           let (fontName, startingIndex, length, fontSize) = (attributes[0], attributes[1].intValue, attributes[2].intValue, attributes[3].intValue)
           
           let start, end: Int32
           switch (startingIndex, length) {
               case let (x, y) where x < 0 && y == 0:
                   start = Int32(text.count) + x
                   end = Int32(text.count)
               case let (x, y) where x < 0 && y > 0:
                   start = Int32(text.count) + x
                   end = start+y
               case let (x, y) where x >= 0 && y > 0:
                   start = x
                   end = x+y
               case let (x, y) where x >= 0 && y == 0:
                   start = x
                   end = Int32(text.count)
               case (_, _):
                   start = 0
                   end = 0
           }
           
           let index2 = text.index(text.startIndex, offsetBy: Int(start))
           let index3 = text.index(text.startIndex, offsetBy: Int(end))

           let text1 = text.prefix(Int(start))
           let text2 = text[index2..<index3]
           let text3 = text[index3..<text.endIndex]
           let font = UIFont(name: fontName, size: CGFloat(fontSize)) ?? UIFont.defaultFont
           print("\(text1)\n\(text2)\n\(text3)\n\(font)")
           let paragraphstyle = NSMutableParagraphStyle()
           paragraphstyle.alignment = alignment
           let attributed = NSMutableAttributedString(string:String(text1), attributes: [NSAttributedString.Key.font: getFont(), NSAttributedString.Key.foregroundColor: getTextColor()])
           attributed.append(NSAttributedString(string:String(text2), attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: getAttributedTextColor() ?? getTextColor()]))
           attributed.append(NSAttributedString(string:String(text3), attributes: [NSAttributedString.Key.font: getFont(), NSAttributedString.Key.foregroundColor: getTextColor()]))
           attributed.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphstyle, range: NSRange(location: 0, length: attributed.length))
           return attributed
       }
}

enum ContentKeys: String, CodingKey {
    
    case nav_bar, AppSettings, payment_types
    
    case welcome_title_1, welcome_title_2, welcome_title_3, welcome_message_1, welcome_message_2, welcome_message_3, welcome_sub_message_3, welcome_button
    
    case doctors_collection_title, doctors_collection_subtitle, doctors_collection_name, doctors_collection_category, doctors_collection_center, doctors_collection_button_connect, doctors_collection_button_online, doctors_collection_button_offline, doctors_collection_center_available
    
    case popover_background, popover_title, popover_subtitle, popover_main_button, popover_subtitle_available_in, popover_description, popover_card_text, popover_amount
    
    case short_popover_available, short_popover_unavailable, short_popover_subtitle, short_popover_unavailable_text
    
    case alert_title, alert_description
    
    case faq_title, faq_description
}

enum ContentStyleCodingKeys: String, CodingKey {
    case attributedStyle, style, text
}

enum ConsulationStatus: String {
    case none, requested, in_progress
}

enum Fonts: String, RawRepresentable {
    case GothamBook = "GothamHTF-Book"
    case GothamMedium = "GothamHTF-Medium"
    case GothamUltra = "GothamHTF-Ultra"
    case GothamBold = "GothamHTF-Bold"
}
