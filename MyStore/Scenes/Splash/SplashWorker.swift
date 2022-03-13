//
//  SplashWorker.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

class SplashWorker {
 
    let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
    }
}

extension SplashWorker: SplashWorkerProtocol {
    func fetchProducts(completionHandler: @escaping GenericResultClosure<[Product]>) {
        serviceManager.request(wrapper: ServiceWrapper(module: ProductServiceModule.fetchProducts), completion: completionHandler)
    }
}
