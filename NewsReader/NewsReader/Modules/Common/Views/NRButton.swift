//
//  NRButton.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

class NRButton: UIButton {

    init(backgroundColor: UIColor, titleColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.insetsLayoutMarginsFromSafeArea = true
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: Constants.kContentPadding, bottom: 0, right: Constants.kContentPadding)
    }

    // Common setup code
    private func setupUI() {
        // Additional setup if needed
        self.layer.cornerRadius = Constants.kCornerRadius
        self.clipsToBounds = true
        self.titleLabel?.font = .emphasisBold
    }
}

extension NRButton {
    private enum Constants {
        static let kCornerRadius: CGFloat = 10.0
        static let kContentPadding: CGFloat = 10.0
    }
}


