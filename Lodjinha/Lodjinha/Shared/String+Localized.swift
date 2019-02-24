//
//  String+Localized.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
