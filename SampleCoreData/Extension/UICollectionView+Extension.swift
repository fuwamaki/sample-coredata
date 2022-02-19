//
//  UICollectionView+Extension.swift
//  SampleCoreData
//
//  Created by fuwamaki on 2022/02/19.
//

import UIKit

extension UICollectionView {
    func registerForCell<T>(_: T.Type) where T: UICollectionViewCell, T: NibLoadable {
        register(T.loadNib(), forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func registerForCell<T>(_: T.Type) where T: UICollectionViewCell {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueCellForIndexPath<T>(_ indexPath: IndexPath, identifier: String? = nil) -> T where T: UICollectionViewCell {
        let reuseIdentifier = identifier ?? T.defaultReuseIdentifier
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}
