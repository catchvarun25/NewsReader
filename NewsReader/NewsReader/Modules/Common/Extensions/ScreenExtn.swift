//
//  ScreenExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension UIScreen {
    /// Screen width
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// Screen height
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// Screen size
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    /// Screen bounds
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    /// Screen scale
    static var screenScale: CGFloat {
        return UIScreen.main.scale
    }
        
    /// Navigation bar height (approximate, standard height)
    static var navigationBarHeight: CGFloat {
        return 44.0
    }
    
    /// Tab bar height (approximate, standard height)
    static var tabBarHeight: CGFloat {
        return 49.0
    }    
}
