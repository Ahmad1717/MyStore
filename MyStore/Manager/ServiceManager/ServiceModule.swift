//
//  ServiceModule.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

public typealias Parameters = [String: Any]

public enum ContentType {
    case jsonEncoded
    case urlEncoded
}

protocol ServiceModule {
    var method: RequestMethod { get }
    var parameters: Parameters? { get }
    var module: Module? { get }
    var path: Path? { get }
    var contentType: ContentType { get }
    func url(baseUrl: URL?) -> URL?
}

extension ServiceModule {

    func url(baseUrl: URL?) -> URL? {

        var url = baseUrl

        if let module = module {
            url?.appendPathComponent("/\(module.rawValue)")
        }

        if let path = path {
            url?.appendPathComponent("/\(path.rawValue)")
        }

        return url
    }
}

extension ServiceModule {
    var method: RequestMethod { .get }
    var parameters: Parameters? { nil }
    var module: Module? { nil }
    var path: Path? { nil }
    var contentType: ContentType { .urlEncoded }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Module: String {
    
    case products = "b"
}

enum Path: String {
    
    case id = "UKQI"
}
