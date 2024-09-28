//
//  NRSButton.swift
//  NewsReader
//
//  Created by Varun Mehta on 28/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct NRSButton: View {
    var title: String?
    var leftIcon: String?
    var rightIcon: String?
    var tintColor: Color?
    var titleColor: Color?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let leftIcon = leftIcon {
                    Image(systemName: leftIcon)
                        .foregroundColor(tintColor)
                }
                if let title = title {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(titleColor)
                }
                if let rightIcon = rightIcon {
                    Image(systemName: rightIcon)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}
