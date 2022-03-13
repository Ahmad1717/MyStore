//
//  UICollectionViewExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("DequeueReusableCell failed while casting")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(_ : T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionViewCell>(_ : T.Type) {
        register(T.nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionReusableView>(_ : T.Type) {
        register(T.self, forSupplementaryViewOfKind: T.identifier, withReuseIdentifier: T.identifier)
    }

    func registerNib<T: UICollectionReusableView>(_ : T.Type) {
        register(T.nib, forSupplementaryViewOfKind: T.identifier, withReuseIdentifier: T.identifier)
    }
}
