//
//  AppDelegate.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        start()
        return true
    }

}

private extension AppDelegate {
    func start() {
        
        // JailBroken Check
        SecurityHelper.checkForBreaking { [weak self] broken in
            guard let weakSelf = self else { return }
            
            let splashController = SplashConfigurator.viewController(input: .init(isValid: !broken))
            let navigationController = UINavigationController(rootViewController: splashController)
            
            weakSelf.window?.rootViewController = navigationController
        }
    }
}

extension AppDelegate {
    static var shared: AppDelegate? { UIApplication.shared.delegate as? AppDelegate }
    
    var rootViewController: UIViewController? {
        get { return window?.rootViewController }
        set {
            window?.rootViewController = newValue
            guard let currentWindow = window else { return }
            UIView.transition(with: currentWindow, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

