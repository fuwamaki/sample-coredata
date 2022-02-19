//
//  UICollectionViewCell+Extension.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit

extension UICollectionViewCell {
    class var defaultSize: CGSize {
        return CGSize(width: 44.0, height: 44.0)
    }

    class var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
