//
//  UINavigationBar.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

enum NavigationBarType {
    case white
    case whiteWithBottomBorder
}

extension UINavigationController {
    func setNavigationBar(type: NavigationBarType) {
        let appearance = UINavigationBarAppearance()
        // Back Button
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        backButtonAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backButtonAppearance
        let backImage = UIImage(named: "red_back_arrow")?.withRenderingMode(.alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

        switch type {
        case .white:
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .primaryBackgroundNR

        case .whiteWithBottomBorder:
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .primaryBackgroundNR
        }
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
