//
//  UIDeviceExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

extension UIDevice {
    var isSimulator: Bool { TARGET_OS_SIMULATOR != 0 }
}
