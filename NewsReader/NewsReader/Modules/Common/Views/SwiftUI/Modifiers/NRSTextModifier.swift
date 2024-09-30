//
//  NRSTextModifier.swift
//  NewsReader
//
//  Created by Varun Mehta on 30/9/24.
//  Copyright © 2024 Target. All rights reserved.
//

import Foundation
import SwiftUI

struct H1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 18.0))
    }
}
struct H1Bold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.custom("Helvetica", size: 18.0))())
    }
}

struct H2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 16.0))
    }
}
struct H2Bold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.custom("Helvetica", size: 16.0))())
    }
}

struct H3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 14.0))
    }
}
struct H3Bold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.custom("Helvetica", size: 14.0))())
    }
}

struct H4: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 12.0))
    }
}
struct H4Bold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.custom("Helvetica", size: 12.0))())
    }
}



extension View {
    func h1() -> some View {
        self.modifier(H1())
    }
    func h1Bold() -> some View {
        self.modifier(H1Bold())
    }
    func h2() -> some View {
        self.modifier(H2())
    }
    func h2Bold() -> some View {
        self.modifier(H2Bold())
    }
    func h3() -> some View {
        self.modifier(H3())
    }
    func h3Bold() -> some View {
        self.modifier(H3Bold())
    }
    func h4() -> some View {
        self.modifier(H4())
    }
    func h4Bold() -> some View {
        self.modifier(H4Bold())
    }
}
