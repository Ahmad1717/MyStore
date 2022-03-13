//
//  Alert.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class Alert {

    private var alertController: UIAlertController

    init(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    }

    func addAction(title: String = "", style: UIAlertAction.Style = .default, handler: (() -> Void)? = { }) -> Self {
        alertController.addAction(UIAlertAction(title: title, style: style, handler: { _ in handler?() }))
        return self
    }

    func build() -> UIAlertController {
        return alertController
    }
}

extension UIAlertController {
    func show(animated: Bool = true, completionHandler: (() -> Void)? = nil) {
        topController()?.present(self, animated: animated, completion: completionHandler)
    }
}
