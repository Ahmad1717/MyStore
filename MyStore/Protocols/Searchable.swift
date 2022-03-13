//
//  Searchable.swift
//  MyStore
//
//  Created by Ahmad Jabri on 14/03/2022.
//

import Foundation

public protocol Searchable {
    func passesSearch(for key: String) -> Bool
}
