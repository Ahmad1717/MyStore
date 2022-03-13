//
//  SplashViewController.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class SplashViewController: BaseViewController {

    // MARK: - Properties
    var output: SplashInteractorInput?
    var router: SplashRouterProtocol?
    
    @IBOutlet private weak var startButton: UIButton?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    @IBAction func didTapStart(_ sender: UIButton) {
        output?.fetchProducts()
    }
}

private extension SplashViewController {
    
    // MARK: - Configure View
    func configureView() {
        output?.initView()
    }
}

// MARK: - The data that the Presenter sends
extension SplashViewController: SplashPresenterOutput {
    
    func navigateToProductsScreen() {
        router?.navigateToProductsScreen()
    }
    
    func initView(model: SplashUIModel ) {
        startButton?.setTitle(model.buttonTitle, for: .normal)
        startButton?.backgroundColor = model.buttonBackgroundColor
        startButton?.setTitleColor(model.buttonTitleColor, for: .normal)
    }
    
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
    
    func showError(message: String) {
        Alert(title: &&"Common.Error", message: message, preferredStyle: .alert)
            .addAction(title: &&"Common.Ok", style: .cancel, handler: nil)
            .build()
            .show()
    }
}
