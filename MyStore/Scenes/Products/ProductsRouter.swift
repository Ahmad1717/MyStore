//
//  ProductsRouter.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class ProductsRouter {
    weak var viewController: ProductsViewController?
    
    // MARK: - Init
    init(viewController: ProductsViewController) {
        self.viewController = viewController
    }
}

extension ProductsRouter: ProductsRouterProtocol {
    
}
