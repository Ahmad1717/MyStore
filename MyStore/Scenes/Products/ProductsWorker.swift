//
//  ProductsWorker.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

class ProductsWorker {
 
    let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
}

extension ProductsWorker: ProductsWorkerProtocol {
 
}
