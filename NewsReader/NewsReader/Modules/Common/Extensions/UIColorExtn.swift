//
//  UIColorExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SwiftUI

extension UIColor {
    static let grayDarkestNR = UIColor(hex: 0x333333)
    static let grayMediumNR = UIColor(hex: 0x888888)
    static let grayLightNR = UIColor(hex: 0xD6D6D6)
    static let redNR = UIColor(hex: 0xCC0000)
    static let textRedNR = UIColor(hex: 0xAA0000)
    static let textGreenNR = UIColor(hex: 0x008300)
    static let textLightGrayNR = UIColor(hex: 0x666666)
    static let textBlackNR = UIColor(hex: 0x000000)
    static let textWhiteNR = UIColor(hex: 0xFFFFFF)
    static let thinBorderGrayNR = UIColor(hex: 0xD6D6D6)
    static let primaryBackgroundNR = UIColor(hex: 0xFFFFFF)
    static let secondaryBackgroundNR = UIColor(hex: 0xF7F7F7)
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}


extension Color {
    static let redNR = Color(UIColor(hex: 0xCC0000))
    static let grayLightNR = Color(UIColor(hex: 0xD6D6D6))
}
