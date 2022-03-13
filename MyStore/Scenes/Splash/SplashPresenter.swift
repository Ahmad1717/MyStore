//
//  SplashPresenter.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

class SplashPresenter {
    weak var output: SplashPresenterOutput?
    
    init(output: SplashPresenterOutput) {
        self.output = output
    }
}

extension SplashPresenter: SplashPresenterInput {
    
    func showProductsScreen() {
        output?.navigateToProductsScreen()
    }
    
    func initView() {
        output?.initView(model: .init(buttonTitle: &&"Common.Start",
                                      buttonBackgroundColor: .navigationColor,
                                      buttonTitleColor: .white))
    }
    
    func showLoading() {
        output?.showLoading()
    }
    
    func hideLoading() {
        output?.hideLoading()
    }
    
    func showError(error: MSError) {
        output?.showError(message: error.message)
    }
}
