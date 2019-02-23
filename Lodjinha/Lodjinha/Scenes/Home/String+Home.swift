//
//  String+Home.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

extension String {
  struct Home {
    static var tabBar: String {
      return "HOME_TABBAR".localized
    }

    static var categories: String {
      return "HOME_CATEGORIES".localized
    }

    static var bestsellers: String {
      return "HOME_BESTSELLERS".localized
    }

    static var priceFrom: String {
      return "HOME_PRICEFROM".localized
    }

    static var priceTo: String {
      return "HOME_PRICETO".localized
    }
  }
}
