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
    
    init(input: ProductsInput, output: ProductsPresenterInput, worker: ProductsWorker) {
        self.input = input
        self.output = output
        self.worker = worker
    }
}

extension ProductsInteractor: ProductsInteractorInput {
    
    func switchTo(index: Int) {
        output?.reload(products: input.products, for: Brand.allCases[index])
    }
    
    func initView() {
        output?.initView(products: input.products)
    }
}
