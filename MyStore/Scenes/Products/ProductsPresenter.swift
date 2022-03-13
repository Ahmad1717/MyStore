//
//  ProductsPresenter.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class ProductsPresenter {
    weak var output: ProductsPresenterOutput?
    
    init(output: ProductsPresenterOutput) {
        self.output = output
    }
}

extension ProductsPresenter: ProductsPresenterInput {
    
    func initView(products: [Product]) {
        output?.initView(model: .init(categories: map(brands: [Brand.apple, Brand.ericsson]),
                                      products: map(products: products, for: .apple)))
    }
    
    func reload(products: [Product], for brand: Brand) {
        output?.reloadView(model: .init(categories: map(brands: [Brand.apple, Brand.ericsson]),
                                      products: map(products: products, for: brand)))
    }
}

private extension ProductsPresenter {
    func map(products: [Product], for brand: Brand) -> [ProductsUIModel.ProductUIModel] {
        return products.filter { $0.brand == brand }.map { ProductsUIModel.ProductUIModel(name: $0.phone ?? "",
                                                                                          description: getDescription(announceDate: $0.announceDate?.stringValue,
                                                                                                                      sim: $0.sim,
                                                                                                                      resolution: $0.resolution,
                                                                                                                      audio: $0.audio,
                                                                                                                      gps: $0.gps,
                                                                                                                      battery: $0.battery),
                                                             price: String($0.price?.intValue ?? 0),
                                                             brand: $0.brand ?? .apple,
                                                             image: $0.picture ?? "") }
    }
    
    func map(brands: [Brand]) -> SegmentControl.Presentable {
        return SegmentControl.Presentable(items: brands.map { SegmentControl.UIModel(title: $0.rawValue) })
    }
    
    func getDescription(announceDate: String?,
                        sim: String?,
                        resolution: String?,
                        audio: String?,
                        gps: String?,
                        battery: String?) -> String {
        return "Announce Date: \(announceDate ?? ""), SIM: \(sim ?? ""), Resolution: \(resolution ?? ""), Audio: \(audio ?? ""), GPS: \(gps ?? ""), Battery: \(battery ?? "")"
    }
}
