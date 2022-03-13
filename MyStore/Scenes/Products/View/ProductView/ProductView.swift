//
//  ProductView.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit
import SDWebImage

/// Presentable
extension ProductView {
    struct Presentable {
        let productName: String
        let productPrice: String
        let productImage: String
        let productDescription: String
    }
}

class ProductView: UIView {
        
    var presentable: Presentable? {
        didSet {
            configureView()
        }
    }
    
    var mode = Mode.partial
    
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var detailsViewTopSpaceConstraint: NSLayoutConstraint?
    @IBOutlet private weak var productNameLabel: UILabel?
    @IBOutlet private weak var productDescriptionLabel: UILabel?
    @IBOutlet private weak var rateView: UIView?
    @IBOutlet private weak var priceLabel: UILabel?
    
    @IBOutlet private weak var descriptionStackView: UIStackView?
    @IBOutlet private weak var bagButton: UIButton?
    @IBOutlet private weak var moreButton: UIButton?
    @IBOutlet private weak var likeButton: UIButton?
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Common initializer
    func commonInit() {
        fromNib()
        bagButton?.setTitle("", for: .normal)
        moreButton?.setTitle("", for: .normal)
        likeButton?.setTitle("", for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView?.addGestureRecognizer(tapGesture)
        
        let descriptionTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDescriptionView))
        descriptionStackView?.addGestureRecognizer(descriptionTapGesture)
    }
    
    func handleMode(mode: Mode) {
        self.mode = mode
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn) { [weak self] in
            self?.productDescriptionLabel?.isHidden = self?.mode == .partial
            self?.rateView?.isHidden = self?.mode == .partial
            self?.detailsViewTopSpaceConstraint?.constant = self?.mode == .partial ? 200 : 0
            
        }
    }
}

private extension ProductView {
    
    func configureView() {
        guard let presentable = presentable else { return }
        
        productNameLabel?.text = presentable.productName
        productDescriptionLabel?.text = presentable.productDescription
        priceLabel?.text = presentable.productPrice + " €"
        
        imageView?.loadImageFromURL(urlString: presentable.productImage)
        
    }
    
    func getImage(stringUrl: String) -> UIImage {
        
        guard let url = URL(string: stringUrl), let data = try? Data(contentsOf: url) else { return UIImage() }
        return UIImage(data: data) ?? UIImage()
    }
    
    @objc private func didTapImage() {
        handleMode(mode: .full)
    }
    
    @objc private func didTapDescriptionView() {
        handleMode(mode: self.mode == .partial ? .full : .partial)
    }
}

extension ProductView {
    enum Mode {
        case full
        case partial
    }
}
