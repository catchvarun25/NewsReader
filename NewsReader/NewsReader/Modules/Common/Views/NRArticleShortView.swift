//
//  NRArticleShortView.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SnapKit

final class NRArticleShortView: UIView {
    
    //MARK: Private Accessors -
    private let mainStack: UIStackView = .horizontal.with(spacing: 16.0)
    private let articleDetailStack: UIStackView = .vertical.with(alignment: .leading)
    private let articleImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = Constants.kCornerRadius
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()

    private let titlelabel: UILabel = {
        let label = UILabel(font: .medium, color: .textBlackNR)
        label.numberOfLines = Constants.kMaxLinesForTitle
        return label
    }()
    private let footerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .primaryBackgroundNR
        
        addSubview(mainStack)
        mainStack <<< articleImage
                  <<< articleDetailStack
        articleDetailStack <<< titlelabel
                           <<< 10.0
                           <<< footerLabel
                           <<< NRSpacerView()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }

        articleImage.snp.makeConstraints { make in
            make.width.equalTo(Constants.kImageSize)
        }
    }
    
    func configureView(data: ArticleDisplayModel) {
        guard let title = data.title else { return }
        // Article Image
        articleImage.sd_setThumbnailImage(with: data.imageURL, placeholder: nil, size: Constants.kImageSize.size)
        // Description Label
        titlelabel.setText(title, withLineHeight: 19.0)
        
        // Source Label
        footerLabel.attributedText = data.footerDisplay
        
    }
}

extension NRArticleShortView {
    private enum Constants {
        static let kCornerRadius: CGFloat = 10.0
        static let kImageSize: CGFloat = 140.0
        static let kMaxLinesForTitle = 6
    }
}
