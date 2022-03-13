//
//  ServiceWrapper.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

class ServiceWrapper {

    private (set) var serviceModule: ServiceModule

    init(module: ServiceModule) {
        serviceModule = module
    }
}

extension ServiceWrapper {

    var defaultParameters: Parameters? { [:] }

    var parameters: Parameters? {
        serviceModule.parameters
    }

    var method: RequestMethod {
        serviceModule.method
    }

    var url: URL? {
        serviceModule.url(baseUrl: Environment.baseURL)
    }

    var contentType: ContentType { serviceModule.contentType }
}
