//
//  Utils.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

typealias GenericClosure<T> = (T) -> Void
typealias VoidClosure = () -> Void
typealias GenericResultClosure<T> = GenericClosure<Result<T>>

// find top most view controller
func topController() -> UIViewController? {

    // recursive follow
    func follow(_ from: UIViewController?) -> UIViewController? {
        if let to = (from as? UITabBarController)?.selectedViewController {
            return follow(to)
        } else if let to = (from as? UINavigationController)?.visibleViewController {
            return follow(to)
        } else if let to = from?.presentedViewController {
            return follow(to)
        } else {
            return from
        }
    }

    let root = UIApplication.shared.keyWindow?.rootViewController

    return follow(root)
}

func FTLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    debugPrint(items[0], separator: separator, terminator: terminator)
}
