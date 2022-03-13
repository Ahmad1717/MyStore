//
//  Enviroment.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

enum Environment {
    
    static func value(for key: Environment.Key) throws -> String {
        guard let configuration = Bundle.main.object(forInfoDictionaryKey: Key.configuration.rawValue) as? [String: Any],
              let value = configuration[key.rawValue] as? String
        else {
            throw Error.missingKey
        }
        
        return value.replacingOccurrences(of: "\\", with: "")
    }
    
    // URLs
    static let baseURL = getURL(for: .baseURL)
    
}

private extension Environment {
    static func getURL(for key: Environment.Key) -> URL {
        return URL(string: getString(for: key)) ?? URL(fileURLWithPath: "")
    }
    
    static func getString(for key: Environment.Key) -> String {
        return (try? value(for: key)) ?? ""
    }
}

extension Environment {
    enum Key: String {
        case configuration = "Configuration"
        case baseURL = "BASE_URL"
        
    }
    
    enum Error: Swift.Error {
        case missingKey
    }
}
