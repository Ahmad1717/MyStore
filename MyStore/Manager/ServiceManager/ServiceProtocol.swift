//
//  ServiceProtocol.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

protocol ServiceProtocol {
    func request<T: Decodable>(wrapper: ServiceWrapper, completion: @escaping GenericClosure<Result<T>>)
}

extension ServiceProtocol {
    func request<T: Decodable>(wrapper: ServiceWrapper, completion: @escaping GenericClosure<Result<T>>) {
        request(wrapper: wrapper, completion: completion)
    }
}

