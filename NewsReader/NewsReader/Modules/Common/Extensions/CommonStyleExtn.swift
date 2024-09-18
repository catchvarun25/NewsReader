//
//  CommonStyleExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 14/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    static func all(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
    static func horizontal(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: value, bottom: 0.0, right: value)
    }
    static func vertical(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: 0.0, bottom: value, right: 0.0)
    }
}
