//
//  ImageNetworking.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct ImageNetworking {
  static func getImage(urlString: String, completion: @escaping (() throws -> Data) -> Void) {
    HTTPService.request(method: Method.get, urlString: urlString, completion: completion)
  }
}
