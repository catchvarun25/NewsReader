//
//  UIViewSafeExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 18/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension UIView {
    func safeRemoveFromSuperView() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }
}
