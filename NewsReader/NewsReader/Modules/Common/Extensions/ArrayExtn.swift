//
//  ArrayExtn.swift
//  NewsReader
//
//  Created by Varun Mehta on 13/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        get {
            guard index >= 0 && index < count else { return nil }
            return self[index]
        }
        set {
            guard let newValue = newValue else { return }
            guard index >= 0 && index < count else { return }
            self[index] = newValue
        }
    }
}
