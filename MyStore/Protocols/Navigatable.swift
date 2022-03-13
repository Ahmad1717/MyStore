//
//  Navigatable.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

protocol Navigatable {}

extension UIViewController: Navigatable {}

extension Navigatable where Self: UIViewController {

    typealias UpdateHandler = (Self) -> Void

    static func push(storyboard: UIStoryboard.Storyboard, navigationController: UINavigationController? = nil, shouldPreventMultiplePushing: Bool = true, updateHandler: UpdateHandler? = nil) {
        
        // get the view controller to push
        let pushingController = instantiate(from: storyboard)
        
        // push
        pushingController.push(navigationController: navigationController, shouldPreventMultiplePushing: shouldPreventMultiplePushing, updateHandler: updateHandler)
    }
    
    func push(navigationController: UINavigationController? = nil, shouldPreventMultiplePushing: Bool = true, updateHandler: UpdateHandler? = nil, animated: Bool = true) {
        
        // abort if we dont have a navigation controller
        guard let currentNavigationController = navigationController ?? topController()?.navigationController else { return }
        
        // abort if we are inhibiting multiple pushes and if the top contoller is the controller we are trying to push
        guard !(shouldPreventMultiplePushing && type(of: topController() ?? UIViewController()) == type(of: self)) else { return }
        
        // update the controller to push
        updateHandler?(self)
        
        // push
        currentNavigationController.pushViewController(self, animated: animated)
    }
}
