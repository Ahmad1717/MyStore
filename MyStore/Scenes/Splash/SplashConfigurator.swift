//
//  SplashConfigurator.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//


struct SplashInput {
    var isValid: Bool
}

// MARK: - Configuration
final class SplashConfigurator {
    
    class func viewController(input: SplashInput) -> SplashViewController {
        let viewController = SplashViewController.instantiate(from: .splash)
        let presenter = SplashPresenter(output: viewController)
        let interactor = SplashInteractor(input: input,
                                          output: presenter,
                                          worker: SplashWorker(serviceManager: ServiceManager.shared))
        let router = SplashRouter(viewController: viewController, dataStore: interactor)
        
        viewController.output = interactor
        viewController.router = router
        
        return viewController
    }
}

// MARK: - Protocol

/// ViewController -> Interactor
protocol SplashInteractorInput {
    func initView()
    func fetchProducts()
}

/// Interactor -> Presenter
protocol SplashPresenterInput {
    func showLoading()
    func hideLoading()
    func showProductsScreen()
    func initView()
    func showError(error: MSError)
}

/// Presenter -> Controller
protocol SplashPresenterOutput: AnyObject {
    func initView(model: SplashUIModel)
    func showLoading()
    func hideLoading()
    func navigateToProductsScreen()
    func showError(message: String)
}

/// Router
protocol SplashRouterProtocol {
    func navigateToProductsScreen()
}

/// DataStore
protocol SplashDataStoreProtocol: AnyObject {
    var prouctsStore: [Product] { get}
}

/// Worker
protocol SplashWorkerProtocol: AnyObject {
    func fetchProducts(completionHandler: @escaping GenericResultClosure<[Product]>)
}
