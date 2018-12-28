//
//  Network.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

class Network {
    
    static let timeoutInterval: Double = 30.0
    
    static let defaultHost: String = "https://alodjinha.herokuapp.com/"
    
    static var defaultHeaders: [String: String] {
        return ["content-type": ContentType.json.rawValue]
    }
    
    public enum ContentType: String {
        case urlEncoded = "application/x-www-form-urlencoded"
        case json = "application/json"
    }
    
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    class private func isContentTypeUrlEncoded(_ httpHeaders: [String: String]) -> Bool {
        return httpHeaders.contains(where: { $0 == "content-type" && $1 == ContentType.urlEncoded.rawValue })
    }
    
    class private func fetchGenericData<T: Decodable>(urlString: String,
                                                      httpMethod: HttpMethod = .get,
                                                      httpHeaders: [String: String] = defaultHeaders,
                                                      params: [String: Any]? = nil,
                                                      onCompletion: @escaping (T) -> Void) {
        var components = URLComponents(string: urlString)!
        var httpBody: Data?
        
        if let params = params {
            print("\nParams:")
            dump(params)
     
            if httpMethod == .get || isContentTypeUrlEncoded(httpHeaders) {
                components.queryItems = [URLQueryItem]()
                params.forEach { (key, value) in
                    let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .alphanumerics))
                    components.queryItems?.append(queryItem)
                }
                if isContentTypeUrlEncoded(httpHeaders), let query = components.query {
                    httpBody = query.data(using: .utf8)
                    components.queryItems = nil
                }
            } else {
                do {
                    httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                } catch let error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
        print("\nUrl:", components.url!)
        print("HttpHeaders:", httpHeaders)
        print("HttpMethod:", httpMethod.rawValue)
        if let body = httpBody {
            if let httpBodyJson = try? JSONSerialization.jsonObject(with: body, options: []) {
                print("HttpBody (JSON):", httpBodyJson)
            } else if let httpBodyString = String(data: body, encoding: .utf8) {
                print("HttpBody (String):", httpBodyString)
            }
        }
        
        var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: timeoutInterval)
        request.allHTTPHeaderFields = httpHeaders
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        
        fetchData(request: request, retry: 3) { (data, resp, err) in
            guard let data = data else { return }
            if let httpResponse = resp as? HTTPURLResponse {
                print("Status code:", httpResponse.statusCode)
            }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                onCompletion(obj)
            } catch {
                print("Failed to decode json:", error)
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print("Returned json:", json)
                }
            }
            }.resume()
    }
    
    @discardableResult
    class func fetchData(request: URLRequest, retry: Int, callback: @escaping ((_ data: Data?, _ resp: URLResponse?, _ err: Error?) -> Void)) -> URLSessionDataTask {
        let task = URLSession(configuration: .default).dataTask(with: request) { (data: Data?, resp: URLResponse?, err: Error?) in
            if let error = err {
                print("Failed to fetch data:", error.localizedDescription)
                callback(data, resp, err)
            } else if let response = resp as? HTTPURLResponse, response.statusCode == 504 {
                if retry - 1 > 0 {
                    print("Request timed out, trying to fetch data again (\(retry)) -> \(request.url?.absoluteString ?? "")")
                    fetchData(request: request, retry: retry - 1, callback: callback).resume()
                } else {
                    callback(data, resp, err)
                }
            } else {
                callback(data, resp, err)
            }
        }
        return task
    }

}

//MARK: - Endpoints
extension Network {
    
    class func getBanners(onCompletion: @escaping (BannerResponse) -> Void) {
        let urlString = defaultHost.appending("banner")
        fetchGenericData(urlString: urlString) { (response: BannerResponse) in
            onCompletion(response)
        }
    }
    
    class func getCategorias(onCompletion: @escaping (CategoriaResponse) -> Void) {
        let urlString = defaultHost.appending("categoria")
        fetchGenericData(urlString: urlString) { (response: CategoriaResponse) in
            onCompletion(response)
        }
    }
    
    class func getProdutos(offset: Int, limit: Int, categoriaId: Int, onCompletion: @escaping (ProdutoResponse) -> Void) {
        let urlString = defaultHost.appending("produto")
        let params: [String : Any] = ["offset": offset,
                                      "limit": limit,
                                      "categoryId": categoriaId]
        fetchGenericData(urlString: urlString, params: params) { (response: ProdutoResponse) in
            onCompletion(response)
        }
    }
    
    class func getProdutosMaisVendidos(onCompletion: @escaping (ProdutoResponse) -> Void) {
        let urlString = defaultHost.appending("produto/maisvendidos")
        fetchGenericData(urlString: urlString) { (response: ProdutoResponse) in
            onCompletion(response)
        }
    }
    
    class func getProdutoPorId(produtoId: Int, onCompletion: @escaping (ProdutoResponse) -> Void) {
        let urlString = defaultHost.appending("produto/").appending("\(produtoId)")
        fetchGenericData(urlString: urlString) { (response: ProdutoResponse) in
            onCompletion(response)
        }
    }
    
    class func postReservarProduto(produtoId: Int, onCompletion: @escaping (ProdutoResponse) -> Void) {
        let urlString = defaultHost.appending("produto/").appending("\(produtoId)")
        fetchGenericData(urlString: urlString, httpMethod: .post) { (response: ProdutoResponse) in
            onCompletion(response)
        }
    }
    
}
