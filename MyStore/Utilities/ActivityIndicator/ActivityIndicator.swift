//
//  ActivityIndicator.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import NVActivityIndicatorView

protocol LoadingIndicatorProtocol {
    func show(message: String, color: UIColor, backgroundColor: UIColor)
    func dismiss()
}

class LoadingIndicator: UIViewController, NVActivityIndicatorViewable {

    // singleton
    static let shared = LoadingIndicator()
}

extension LoadingIndicator: LoadingIndicatorProtocol {

    // show loading indicator
    func show(message: String = "", color: UIColor = .navigationColor, backgroundColor: UIColor = .clear) {
        let size = CGSize(width: 50, height: 50)
        startAnimating(size, message: message, type: .lineScalePulseOutRapid, color: color, backgroundColor: backgroundColor)
    }

    // dismiss loading indicator
    func dismiss() {
        stopAnimating()
    }
}
