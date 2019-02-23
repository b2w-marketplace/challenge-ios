//
//  ALodjinhaAPI.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum ALodjinhaError: LocalizedError {
  case endReached
}

struct ALodjinhaAPI {
  private static var baseUrlString: String {
    return "https://alodjinha.herokuapp.com"
  }

  public static var baseUrl: URL {
    guard let url = URL(string: baseUrlString) else { fatalError("invalid base url") }
    return url
  }

  enum Endpoints: String {
    case banner = "/banner"
  }

  static func getBanner(completion: @escaping (() throws -> [Banner]) -> Void) {
    let method = Method.get
    let path = Endpoints.banner.rawValue
    HTTPService.request(method: method, baseUrl: baseUrl, path: path, parameters: nil) { callback in
      do {
        let data = try callback()
        let container = try JSONDecoder().decode(DataContainer<[Banner]>.self, from: data)
        completion { container.data }
      } catch {
        completion { throw error }
      }
    }
  }
}
