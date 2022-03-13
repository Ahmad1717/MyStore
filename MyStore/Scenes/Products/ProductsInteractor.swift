//
//  ProductsInteractor.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class ProductsInteractor {
    var input: ProductsInput
    var output: ProductsPresenterInput?
    var worker: ProductsWorker
    
    private var brand: Brand = .apple
    
    init(input: ProductsInput, output: ProductsPresenterInput, worker: ProductsWorker) {
        self.input = input
        self.output = output
        self.worker = worker
    }
}

extension ProductsInteractor: ProductsInteractorInput {
    func search(for key: String) {
        output?.reload(products: key.isEmpty ? input.products : input.products.filter{ $0.passesSearch(for: key)}, for: brand)
    }
    
    func switchTo(index: Int) {
        let brand = Brand.allCases[index]
        self.brand = brand
        output?.reload(products: input.products, for: brand)
    }
    
    func initView() {
        output?.initView(products: input.products)
    }
}
