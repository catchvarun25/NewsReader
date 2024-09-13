//
//  UIViewSizeExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

//MARK: - Size Extension
extension UIView {
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var x: CGFloat {
        return self.frame.origin.x
    }
    
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    var origin: CGPoint {
        return self.frame.origin
    }
    
    var size: CGSize {
        return self.frame.size
    }
}

extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize = .zero,
        radius: CGFloat = 10,
        cornerRadius: CGFloat = 10,
        corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
        // Apply corner radius
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = corners
        
        // Optimize performance by caching the shadow
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}
