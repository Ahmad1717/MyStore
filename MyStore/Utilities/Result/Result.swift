//
//  Result.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(MSError)
}
