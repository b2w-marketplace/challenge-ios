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
  case custom(String)

  var errorDescription: String? {
    switch self {
    case .custom(let message):
      return message
    default:
      return localizedDescription
    }
  }
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
    case categories = "/categoria"
    case bestsellers = "/produto/maisvendidos"
    case products = "/produto"
    case reserve = "/produto/%d"
  }

  struct Parameters {
    struct Products: ParametersType {
      let offset: Int
      let limit: Int
      let categoryId: Int

      enum CodingKeys: String, CodingKey {
        case offset, limit
        case categoryId = "categoriaId"
      }
    }
  }

  static func getBanner(completion: @escaping (() throws -> [Banner]) -> Void) {
    let method = Method.get
    let path = Endpoints.banner.rawValue
    HTTPService.request(method: method, baseUrl: baseUrl, path: path) { callback in
      do {
        let data = try callback()
        let container = try JSONDecoder().decode(DataContainer<[Banner]>.self, from: data)
        completion { container.data }
      } catch {
        completion { throw error }
      }
    }
  }

  static func getCategories(completion: @escaping (() throws -> [Category]) -> Void) {
    let method = Method.get
    let path = Endpoints.categories.rawValue
    HTTPService.request(method: method, baseUrl: baseUrl, path: path) { callback in
      do {
        let data = try callback()
        let container = try JSONDecoder().decode(DataContainer<[Category]>.self, from: data)
        completion { container.data }
      } catch {
        completion { throw error }
      }
    }
  }

  static func getBestsellers(completion: @escaping (() throws -> [Product]) -> Void) {
    let method = Method.get
    let path = Endpoints.bestsellers.rawValue
    HTTPService.request(method: method, baseUrl: baseUrl, path: path) { callback in
      do {
        let data = try callback()
        let container = try JSONDecoder().decode(DataContainer<[Product]>.self, from: data)
        completion { container.data }
      } catch {
        completion { throw error }
      }
    }
  }

  static func getProducts(with categoryId: Int,
                          page: Int,
                          perPage: Int,
                          completion: @escaping (() throws -> [Product]) -> Void) {
    let method = Method.get
    let path = Endpoints.products.rawValue
    let parameters = Parameters.Products(offset: page * perPage, limit: perPage, categoryId: categoryId)
    HTTPService.request(method: method, baseUrl: baseUrl, path: path, parameters: parameters) { callback in
      do {
        let data = try callback()
        let container = try JSONDecoder().decode(DataContainer<[Product]>.self, from: data)
        if container.data.isEmpty {
          completion { throw ALodjinhaError.endReached }
        } else {
          completion { container.data }
        }
      } catch {
        completion { throw error }
      }
    }
  }

  static func reserveProducts(with productId: Int, completion: @escaping (() throws -> Void) -> Void) {
    let method = Method.post
    let path = String(format: Endpoints.reserve.rawValue, arguments: [productId])
    HTTPService.request(method: method, baseUrl: baseUrl, path: path) { callback in
      do {
        let data = try callback()
        let result = try JSONDecoder().decode(APIResult.self, from: data)
        if let message = result.message {
          completion { throw ALodjinhaError.custom(message) }
        } else {
          completion {}
        }
      } catch {
        completion { throw error }
      }
    }
  }
}
