//
//  NRSpacerView.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit

class NRSpacerView: UIView {
    
    // Initializer for flexible spacer
    init() {
        super.init(frame: .zero)
        setupFlexibleConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFlexibleConstraints()
    }
    
    // Setup constraints for a flexible spacer
    private func setupFlexibleConstraints() {
        self.setContentHuggingPriority(.defaultLow, for: .vertical)
        self.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        self.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
