//
//  UIImage+Home.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UIImage {
  struct Home {
    static var tabBarIcon: UIImage {
      return #imageLiteral(resourceName: "homeDeselected")
    }

    static var tabBarIconSelected: UIImage {
      return #imageLiteral(resourceName: "homeActive")
    }
  }
}
