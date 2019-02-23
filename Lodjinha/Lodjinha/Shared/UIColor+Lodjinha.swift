//
//  UIColor+Lodjinha.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
    self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
  }

  static var purple: UIColor {
    return UIColor(100, 66, 140)
  }
}
