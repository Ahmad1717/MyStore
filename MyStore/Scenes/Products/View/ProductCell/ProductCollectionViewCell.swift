//
//  ProductCollectionViewCell.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var presentable: ProductView.Presentable? {
        didSet {
            configureProductView()
        }
    }
        
    @IBOutlet private weak var productVew: ProductView?
    
}

private extension ProductCollectionViewCell {
    func configureProductView() {
        
        guard let presentable = presentable else { return }
        productVew?.presentable = presentable
    }
}
