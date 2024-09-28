//
//  JSONReader.swift
//  NewsReaderTests
//
//  Created by Varun Mehta on 27/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
@testable import NewsReader


enum JSONReadError: Error {
    case fileNotFound
    case parsingFailed
}

class JSONReader {
    static func readJSON<T: Decodable>(forResource resource: String, 
                                       withExtension ext: String = "json",
                                       as type: T.Type) throws -> T {
        let bundle = Bundle(for: JSONReader.self)
        
        guard let url = bundle.url(forResource: resource, withExtension: ext) else {
            debugPrint("NR: Failed to locate \(resource).\(ext) in bundle.")
            throw JSONReadError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: url)
            debugPrint("NR: Received Data")
            return try JSONParser.decode(data)
        } catch {
            debugPrint("NR: Failed to decode \(resource).\(ext): \(error)")
            throw JSONReadError.parsingFailed
        }
    }
}
