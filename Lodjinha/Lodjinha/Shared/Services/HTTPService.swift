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

//typealias Parameters = [String: Any]

protocol ParametersType: Encodable, JsonEncodable {
  var getEncoded: [URLQueryItem] { get }
  var postEncoded: Data? { get }
}

extension ParametersType {
  var jsonData: Data? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return data
  }

  var json: [String: Any]? {
    guard let jsonData = jsonData,
      let json = try? JSONSerialization
        .jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else { return nil }
    return json
  }
}

protocol Jsonable {
  var json: [String: Any]? { get }
}

typealias Parameters = [String: Any]

extension Dictionary: Jsonable, JsonEncodable where Dictionary == Parameters {
  var json: [String: Any]? {
    return self
  }
}

protocol JsonEncodable: Jsonable {
  var getEncoded: [URLQueryItem] { get }
  var postEncoded: Data? { get }
}

extension JsonEncodable {
  var getEncoded: [URLQueryItem] {
    guard let json = json else { return [] }
    return json.compactMap { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
  }

  var postEncoded: Data? {
    guard let json = json else { return nil }
    let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    return data
  }
}

struct HTTPService {
  static func request(method: Method, urlString: String, completion: @escaping (() throws -> Data) -> Void) {
    guard let url = URL(string: urlString) else { return completion { throw HTTPError.unknown } }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    request(request: urlRequest, completion: completion)
  }

  static func request(method: Method, baseUrl: URL, path: String, completion: @escaping (() throws -> Data) -> Void) {
    let parameters: Parameters? = nil
    request(method: method, baseUrl: baseUrl, path: path, parameters: parameters, completion: completion)
  }

  static func request<T>(method: Method,
                         baseUrl: URL,
                         path: String,
                         parameters: T?,
                         completion: @escaping (() throws -> Data) -> Void) where T: JsonEncodable {
    guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true) else { return }
    urlComponents.path = path
    if method == .get {
      urlComponents.queryItems = parameters?.getEncoded
    }
    guard let url = urlComponents.url else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    if method == .post {
      urlRequest.httpBody = parameters?.postEncoded
    }

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
