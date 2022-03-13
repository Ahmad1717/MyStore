//
//  ProductsUIModel.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

struct ProductsUIModel {
    var categories: SegmentControl.Presentable
    var products: [ProductUIModel]
    
    struct ProductUIModel {
        var name: String
        var description: String
        var price: String
        var brand: Brand
        var image: String
    }
}
