//
//  NSAttributedStringExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    static func attributedString(
        withParts parts: [(text: String?, textColor: UIColor?, font: UIFont?)],
        backgroundColor: UIColor? = nil
    ) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString()
        
        for part in parts {
            guard let displayText = part.text else { continue }
            var attributes: [NSAttributedString.Key: Any] = [:]
            
            if let textColor = part.textColor {
                attributes[.foregroundColor] = textColor
            }
            
            if let font = part.font {
                attributes[.font] = font
            }
            
            let attributedPart = NSAttributedString(string: displayText, attributes: attributes)
            attributedString.append(attributedPart)
        }
        
        if let backgroundColor = backgroundColor {
            attributedString.addAttribute(.backgroundColor, value: backgroundColor, range: NSRange(location: 0, length: attributedString.length))
        }
        
        return attributedString
    }
}
