//
//  UIImageViewExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import UIKit
import SDWebImage


extension UIImageView {
    func sd_setImage(with: String?, placeholderImage: UIImage?) {
        guard let urlString = with, let url = URL(string: urlString) else { return }
        self.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
    
    func sd_setThumbnailImage(with: String?, placeholder: UIImage?, size: CGSize) {
        guard let urlString = with, let url = URL(string: urlString) else { return }
        let scale = UIScreen.main.scale
        let thumbnailSize = CGSize(width: size.width * scale, height: size.height * scale)
        self.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
    }    
}
