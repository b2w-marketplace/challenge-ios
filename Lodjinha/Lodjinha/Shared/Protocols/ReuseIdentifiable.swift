//
//  ReuseIdentifiable.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

protocol ReuseIdentifiable: class {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: ReuseIdentifiable {}

extension UICollectionViewCell: ReuseIdentifiable {}

extension UITableViewHeaderFooterView: ReuseIdentifiable {}
