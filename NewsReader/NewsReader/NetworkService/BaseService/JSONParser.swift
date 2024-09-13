//
//  JSONParser.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
import Combine

struct JSONParser {
    static func decode<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("VARUN: Parser Error: \(error.localizedDescription)")
            throw APIError.parseFailure(message: "Parser Error: \(error.localizedDescription)")
        }
    }
}
