//
//  MSError.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

final public class MSError: Error {
    
    public var code: Int = 0
    public var message = ""
    public var key = ""
    
    var userInfo: [String: Any] {
        return  [NSLocalizedDescriptionKey: message, "code": code]
    }
    
    public convenience init?(_ error: NSError?) {
        guard let error = error else { return nil }
        self.init(code: error.code, key: ErrorKeys.generalError.rawValue, message: error.localizedDescription)
    }
    
    public convenience init?(_ error: Error?) {
        guard let error = error else { return nil }
        self.init(error as NSError)
    }
    
    public init(code: Int = 0, key: String, message: String) {
        self.code = code
        self.key = key
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}

extension MSError {
    enum ErrorKeys: String {
        case generalError = "general_error"
    }
}
