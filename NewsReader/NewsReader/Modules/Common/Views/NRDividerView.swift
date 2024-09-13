//
//  NRDividerView.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

class NRDividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // Common setup function
    private func setupUI() {
        backgroundColor = .grayLightNR
        self.snp.makeConstraints { make in
            make.height.equalTo(0.5)
        }
        self.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
}
