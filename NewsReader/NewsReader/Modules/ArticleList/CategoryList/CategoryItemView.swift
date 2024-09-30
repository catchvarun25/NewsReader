//
//  CategoryItemView.swift
//  NewsReader
//
//  Created by Varun Mehta on 14/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct CategoryItemView: View {
    let data: CategoryTypeDisplayModel
    var body: some View {
        VStack {
            Text(data.name)
                .frame(height: 44.0)
                .h3Bold()
                .padding()
        }
        .background(data.isSelected ? Color.redNR : Color.grayLightNR)
    }
}
