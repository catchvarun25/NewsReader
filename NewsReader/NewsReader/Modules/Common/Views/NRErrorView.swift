//
//  NRErrorView.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

class NRErrorView: UIView {

    private let message: String
    private let messageLabel: UILabel = {
        let label = UILabel(font: .mediumBold, color: .textRedNR)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tryAgainButton: NRButton = {
        let button = NRButton(backgroundColor: .redNR, titleColor: .textWhiteNR)
        button.setTitle("Try Again", for: .normal)
        button.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
        return button
    }()
    
    let tryAgainAction: (() -> Void)?

    init(message: String, handler: (() -> Void)? = nil) {
        self.message = message
        tryAgainAction = handler
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .primaryBackgroundNR

        //Error Message Label
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(Constants.kContentInset)
        }
        messageLabel.text = message
        
        //Try Again Handler
        if tryAgainAction != nil {
            updateHandler()
        }
    }
    
    private func updateHandler() {
        addSubview(tryAgainButton)
        tryAgainButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20.0)
            make.directionalHorizontalEdges.equalToSuperview().inset(Constants.kContentInset)
            make.height.equalTo(44.0)
        }
    }

    @objc
    private func tryAgainTapped() {
        tryAgainAction?()
    }
}

extension NRErrorView {
    private enum Constants {
        static let kContentInset: CGFloat = 16.0
    }
}
