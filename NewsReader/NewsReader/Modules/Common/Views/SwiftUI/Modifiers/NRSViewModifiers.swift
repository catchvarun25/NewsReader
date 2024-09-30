//
//  NRSViewModifiers.swift
//  NewsReader
//
//  Created by Varun Mehta on 28/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorModifier: ViewModifier {
    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


extension View {
    func showLoader(_ isLoading: Binding<Bool>) -> some View {
        self.modifier(ActivityIndicatorModifier(isLoading: isLoading))
    }
}
