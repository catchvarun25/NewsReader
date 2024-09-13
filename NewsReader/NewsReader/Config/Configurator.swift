//
//  Configurator.swift
//  NewsReader
//
//  Created by Varun Mehta on 10/9/24.
//  Copyright © 2024 NewsReader. All rights reserved.
//

import Foundation
enum EnvConfig: String {
    //Error types
    enum ConfigError: Error {
        case missingKey
    }
    //Add your environment base configuration keys from .xcconfig here
    case TARGET_HOST
    case API_KEY
    
    static func value(_ key: EnvConfig) throws -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String else {
            throw ConfigError.missingKey
        }
        return value
    }
}
