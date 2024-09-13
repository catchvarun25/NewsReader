//
//  UIFontExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

extension UIFont {
    static var small: UIFont {
        UIFont(name: "helvetica", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
    }
    
    static var smallBold: UIFont {
        UIFont(name: "helvetica-bold", size: 12.0) ?? UIFont.boldSystemFont(ofSize: 12.0)
    }

    static var medium: UIFont {
        UIFont(name: "helvetica", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    }
    
    static var mediumBold: UIFont {
        UIFont(name: "helvetica-bold", size: 14.0) ?? UIFont.boldSystemFont(ofSize: 14.0)
    }

    static var large: UIFont {
        UIFont(name: "helvetica", size: 21.0) ?? UIFont.systemFont(ofSize: 21.0)
    }
    
    static var largeBold: UIFont {
        UIFont(name: "helvetica-bold", size: 21.0) ?? UIFont.boldSystemFont(ofSize: 21.0)
    }
    
    static var emphasis: UIFont {
        UIFont(name: "helvetica", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
    }
    
    static var emphasisBold: UIFont {
        UIFont(name: "helvetica-bold", size: 18.0) ?? UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    static var copy2: UIFont {
        UIFont(name: "helvetica", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    }
}
