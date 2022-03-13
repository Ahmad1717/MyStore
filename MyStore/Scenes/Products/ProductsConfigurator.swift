//
//  ProductsConfigurator.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

struct ProductsInput {
    var products: [Product]
}

// MARK: - Configuration
final class ProductsConfigurator {
    
    class func viewController(input: ProductsInput) -> ProductsViewController {
        let viewController = ProductsViewController.instantiate(from: .products)
        let presenter = ProductsPresenter(output: viewController)
        let interactor = ProductsInteractor(input: input,
                                          output: presenter,
                                          worker: ProductsWorker(serviceManager: ServiceManager.shared))
        let router = ProductsRouter(viewController: viewController)
        
        viewController.output = interactor
        viewController.router = router
        
        return viewController
    }
}

// MARK: - Protocol

/// ViewController -> Interactor
protocol ProductsInteractorInput {
    func initView()
    func switchTo(index: Int)
}

/// Interactor -> Presenter
protocol ProductsPresenterInput {
    func initView(products: [Product])
    func reload(products: [Product], for brand: Brand)
}

/// Presenter -> Controller
protocol ProductsPresenterOutput: AnyObject {
    func initView(model: ProductsUIModel)
    func reloadView(model: ProductsUIModel)
}

/// Router
protocol ProductsRouterProtocol {

}

/// Worker
protocol ProductsWorkerProtocol: AnyObject {
}
