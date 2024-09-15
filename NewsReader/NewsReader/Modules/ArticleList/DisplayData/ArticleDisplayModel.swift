//
//  ArticleDisplayModel.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

struct ArticleDisplayModel {
    let title: String?
    let author: String?
    let description: String?
    let source: String?
    let articleURL: String?
    let imageURL: String?
    let publishedDate: String?
    
    var footerDisplay: NSAttributedString {
        get {
            .attributedString(withParts: [
                (text: author, textColor: .textGreenNR, font: .small),
                (text: " from " + (source ?? ""), textColor: .textLightGrayNR, font: .small)
            ])
        }
    }
    
    init? (_ response: ArticleResp) {
        guard let title = response.title,
              let imageURL = response.urlToImage,
              let articleURL = response.url else { return nil }
        self.title = title
        self.articleURL = articleURL
        self.imageURL = imageURL
        self.author = response.author
        self.description = response.description
        self.source = response.source?.name
        self.publishedDate = response.publishedAt
    }
}
