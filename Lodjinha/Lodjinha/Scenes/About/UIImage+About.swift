//
//  UIImage+About.swift
//  Lodjinha
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

extension UIImage {
  struct About {
    static var tabBarIcon: UIImage {
      return #imageLiteral(resourceName: "tagDeselected")
    }

    static var tabBarIconSelected: UIImage {
      return #imageLiteral(resourceName: "tagSelected")
    }

    static var logo: UIImage {
      return #imageLiteral(resourceName: "logoSobre")
    }

    static var logoText: UIImage {
      return #imageLiteral(resourceName: "logoText_")
    }
  }
}
