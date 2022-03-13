//
//  SegmentControlCollectionViewCell.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

class SegmentControlCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var mainView: UIView?
    @IBOutlet private weak var selectedView: UIView?
    
    var textFrame: CGRect {
        guard let titleLabel = titleLabel else { return CGRect.zero }
        
        let string = NSString(string: titleLabel.text ?? "")
        let size = string.boundingRect(with: titleLabel.bounds.size,
                                       options: .truncatesLastVisibleLine,
                                       attributes: [.font: titleLabel.font as Any],
                                       context: nil).size
        return CGRect(x: titleLabel.frame.midX - (size.width / 2),
                      y: titleLabel.frame.midY - (size.height / 2),
                      width: size.width,
                      height: size.height)
    }
}

extension SegmentControlCollectionViewCell {
    struct Presentable {
        var title: String?
    }
    
    func configure(_ presentable: Presentable) {
        self.titleLabel?.text = presentable.title
        mainView?.layer.masksToBounds = true
        mainView?.layer.cornerRadius = 16
        backgroundColor = .clear
    }
    
    func setSelected(_ isSelected: Bool) {
        selectedView?.isHidden = !isSelected
    }
}
