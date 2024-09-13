//
//  UIStackViewExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

// Define the custom infix operator
infix operator <<<: AdditionPrecedence

// Extend UIStackView to use the custom operator
extension UIStackView {
    @discardableResult
    static func <<< (stackView: UIStackView, view: UIView) -> UIStackView {
        stackView.addArrangedSubview(view)
        return stackView
    }
    
    @discardableResult
    static func <<< (stackView: UIStackView, space: CGFloat) -> UIStackView {
        let spacerView = UIView()
        spacerView.snp.makeConstraints { make in
            if stackView.axis == .vertical {
                make.height.equalTo(space)
            } else {
                make.width.equalTo(space)
            }
        }
        stackView.addArrangedSubview(spacerView)
        return stackView
    }
}


extension UIStackView {
    static var vertical: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }
    
    static var horizontal: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }
    
    // MARK: - Convenience Methods
    func with(spacing: CGFloat) -> UIStackView {
        self.spacing = spacing
        return self
    }
    
    func with(alignment: UIStackView.Alignment) -> UIStackView {
        self.alignment = alignment
        return self
    }
    
    func with(distribution: UIStackView.Distribution) -> UIStackView {
        self.distribution = distribution
        return self
    }
    
    func with(padding: CGFloat) -> UIStackView {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return self
    }

    func withHorizontal(padding: CGFloat) -> UIStackView {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        return self
    }

    func withVertical(padding: CGFloat) -> UIStackView {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        return self
    }

}
