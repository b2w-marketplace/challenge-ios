//
//  HTTPError.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum HTTPError: LocalizedError {
  case unknown

  var errorDescription: String? {
    switch self {
    case .unknown:
      return String.Services.unknownError
    }
  }
}
