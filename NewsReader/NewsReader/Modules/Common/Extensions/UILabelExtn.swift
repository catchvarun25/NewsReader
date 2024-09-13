//
//  UILabelExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont, color: UIColor) {
        self.init()
        self.font = font
        self.textColor = color
    }
}

/***
 Update line height while setting text
 **/
extension UILabel {
    func setText(_ text: String, withLineHeight lineHeight: CGFloat) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = lineHeight - self.font.pointSize
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: text.count))
        self.attributedText = NSAttributedString(attributedString: attributedString)
    }
}

