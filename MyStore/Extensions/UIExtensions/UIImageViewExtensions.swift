//
//  UIImageViewExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

extension UIImageView {
    func loadImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        sd_setImage(with: url, placeholderImage: UIImage(), options: [.continueInBackground, .queryDiskDataSync, .avoidDecodeImage]) { [weak self] image, error, _, _ in
            guard let weakSelf = self else { return }
            
            if let image = image {
                weakSelf.image = image
            }
        }
    }
}
