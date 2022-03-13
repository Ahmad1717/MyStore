//
//  SplashRouter.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class SplashRouter {
    weak var viewController: SplashViewController?
    weak var dataStore: SplashDataStoreProtocol?
    
    // MARK: - Init
    init(viewController: SplashViewController,
         dataStore: SplashDataStoreProtocol) {
        self.viewController = viewController
        self.dataStore = dataStore
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigateToProductsScreen() {
        guard let dataStore = dataStore else { return }
        ProductsConfigurator.viewController(input: .init(products: dataStore.prouctsStore)).push()
    }
}
