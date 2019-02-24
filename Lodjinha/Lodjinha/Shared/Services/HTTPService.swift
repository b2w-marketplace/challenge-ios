//
//  HTTPService.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

enum Method: String {
  case get = "GET"
  case post = "POST"
}

struct HTTPService {
  static func request(method: Method, urlString: String, completion: @escaping (() throws -> Data) -> Void) {
    guard let url = URL(string: urlString) else { return completion { throw HTTPError.unknown } }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    request(request: urlRequest, completion: completion)
  }

  static func request(method: Method,
                      baseUrl: URL,
                      path: String,
                      parameters: [String: Any]?,
                      completion: @escaping (() throws -> Data) -> Void) {
    guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else { return }
    urlComponents.path = path
    urlComponents.queryItems = parameters?.compactMap {
      URLQueryItem(name: $0.key, value: String(describing: $0.value))
    }
    guard let url = urlComponents.url else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

    request(request: urlRequest, completion: completion)
  }

  static func request(request: URLRequest, completion: @escaping (() throws -> Data) -> Void) {
    URLSession.shared.dataTask(with: request) { data, response, err in
      #if DEBUG
      print("\n")
      print("--- [REQUEST] \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")
      print("--- [HEADER] \(request.allHTTPHeaderFields ?? [:])")
      if let body = request.httpBody {
        print("--- [BODY] \(String(data: body, encoding: String.Encoding.utf8) ?? "")")
      }
      if let status = (response as? HTTPURLResponse)?.statusCode {
        print("--- [STATUS] \(status)")
      }
      if let res = data, let json = try? JSONSerialization.jsonObject(with: res, options: .allowFragments) {
        print("--- [RESULT] \(json)\n")
      } else {
        print("--- [RESULT] EMPTY\n")
      }
      #endif
      if let data = data {
        completion { data }
      } else if let err = err {
        completion { throw err }
      } else {
        completion { throw HTTPError.unknown }
      }
    }.resume()
  }
}
