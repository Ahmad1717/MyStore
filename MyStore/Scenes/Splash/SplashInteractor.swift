//
//  SplashInteractor.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class SplashInteractor {
    var input: SplashInput
    var output: SplashPresenterInput?
    var worker: SplashWorker
    
    private var products = [Product]()
    
    init(input: SplashInput, output: SplashPresenterInput, worker: SplashWorker) {
        self.input = input
        self.output = output
        self.worker = worker
    }
}

extension SplashInteractor: SplashInteractorInput {
        
    func initView() {
        if input.isValid {
            output?.initView()
        }
    }
    
    func fetchProducts() {
        output?.showLoading()
        worker.fetchProducts { [weak self] result in
            guard let weakSelf = self else { return }
            weakSelf.output?.hideLoading()
            switch result {
            case .success(let products):
                weakSelf.products = products
                weakSelf.output?.showProductsScreen()
            case .failure(let error): weakSelf.output?.showError(error: error)
            }
        }
    }
}

extension SplashInteractor: SplashDataStoreProtocol {
    var prouctsStore: [Product] { products }
}
