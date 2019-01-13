//
//  UICollectionViewExtension.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func registerCell<T: UICollectionViewCell>(_ cell: T.Type) {
        let nib = UINib(nibName: String(describing: cell), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as? T
    }
}
