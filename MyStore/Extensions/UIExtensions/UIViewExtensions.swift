//
//  UIViewExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0.0
        }
    }
}

extension UIView {

    // get nib from bundle
    class var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    // get nib name
    class var nibName: String {
        return identifier
    }
}

extension UIView {
    @discardableResult
    public func fromNib<T: UIView>(named name: String? = nil) -> T? {
        let unwrappedName = name ?? String(describing: type(of: self))
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(unwrappedName, owner: self, options: nil)?.first as? T else {
            return nil
        }
        
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttach(to: self)
        return contentView
    }
    
    func layoutAttach(to parentView: UIView, height: CGFloat? = nil, inset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
        parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        
        guard let height = height else { return }
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        heightConstraint.priority = UILayoutPriority(rawValue: 900)
        heightConstraint.isActive = true
    }
}
