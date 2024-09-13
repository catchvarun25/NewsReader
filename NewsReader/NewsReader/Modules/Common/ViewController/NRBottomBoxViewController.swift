//
//  NRBottomBoxViewController.swift
//  NewsReader
//
//  Created by Varun Mehta on 12/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

class NRBottomBoxViewController: UIViewController {
    
    let buttonBoxView: UIStackView = .horizontal
                                     .with(spacing: 16.0)
                                     .with(padding: 16.0)
    private let primaryBtn = NRButton(backgroundColor: .redNR, titleColor: .textWhiteNR)
    private let secondaryBtn = NRButton(backgroundColor: .primaryBackgroundNR, titleColor: .redNR)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(buttonBoxView)
        buttonBoxView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 12)
        buttonBoxView.backgroundColor = .primaryBackgroundNR
        // Add shadow to the top of buttonBoxView
        buttonBoxView.layer.shadowColor = UIColor.black.cgColor
        buttonBoxView.layer.shadowOpacity = 0.1
        buttonBoxView.layer.shadowOffset = CGSize(width: 0, height: -10)
        buttonBoxView.layer.shadowRadius = 4

        buttonBoxView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(Constants.kHeightBottomBox)
        }
    }
            
    func configurePrimaryButton(title: String, action: Selector, target: Any?) {
        primaryBtn.setTitle(title, for: .normal)
        primaryBtn.addTarget(target, action: action, for: .touchUpInside)
        buttonBoxView <<< primaryBtn
    }
    
    func configureSecondaryButton(title: String, action: Selector, target: Any?) {
        secondaryBtn.setTitle(title, for: .normal)
        secondaryBtn.addTarget(target, action: action, for: .touchUpInside)
        buttonBoxView <<< secondaryBtn
    }
}

extension NRBottomBoxViewController {
    private enum Constants {
        static let kHeightBottomBox: CGFloat = 76.0
    }
}
