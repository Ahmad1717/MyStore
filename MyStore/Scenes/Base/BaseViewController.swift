//
//  BaseViewController.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class BaseViewController: UIViewController {

    var shouldHideNavigationBar: Bool { true }
    var navigationBarTitle: String { "" }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .default }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.navigationColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation bar if required
        navigationController?.setNavigationBarHidden(shouldHideNavigationBar, animated: true)
        
        // set navigation bar title if required
        navigationItem.title = navigationBarTitle
    }
    
    func showLoadingIndicator() {
        LoadingIndicator.shared.show()
    }

    func hideLoadingIndicator() {
        LoadingIndicator.shared.dismiss()
    }
}
