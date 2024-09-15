//
//  NRLabel.swift
//  NewsReader
//
//  Created by Varun Mehta on 14/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import UIKit

class NRLabel: UILabel {
    
    // Custom insets for the label
    var textInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay()
        }
    }
        
    // Custom initializer for setting up the label
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    // Configure the label's appearance
    private func setupLabel() {
        self.numberOfLines = 0
        self.textColor = .textBlackNR
        self.font = .copy2
        self.textAlignment = .center
    }

    // Override to apply insets to the text
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: textInsets)
        super.drawText(in: insetRect)
    }
    
    // Override to calculate the size of the label with insets
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
}

