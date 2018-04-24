//
//  Sinc.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import Foundation

//Mark: BasicSinc - Protocol
enum Resource: String {
    case banner = "/banner"
    case categoria = "/categoria"
    case produto = "/produto"
    case unknow = ""
}

enum Methods: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DETETE"
}

enum ErrorRequest: Error {
    case errorSinc(String)
}

protocol BasicSinc {
    var resource: Resource {get}
    var queryString: String? {get set}
    func responseRequest(error: ErrorRequest?, data: Data?)
}

extension BasicSinc {
    var baseURL: String {
        return "https://alodjinha.herokuapp.com"
    }
    
    fileprivate func request(method: Methods) {
        guard let url = URL(string: baseURL + resource.rawValue + (queryString ?? "")) else {
            responseRequest(error: .errorSinc("Invalid URL"), data: nil)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                self.responseRequest(error: .errorSinc("Error: \(error!.localizedDescription)"), data: nil)
                return
            }
            let httpResponse = response as! HTTPURLResponse
            guard httpResponse.statusCode == 200 else {
                self.responseRequest(error: .errorSinc("Invalid Response: \(httpResponse.statusCode)"), data: nil)
                return
            }
            
            self.responseRequest(error: nil, data: data)
        }.resume()
    }
}

//MARK: BannerSinc - Class
protocol BannerSincDelegate: class {
    func finishRequestBanner(banner: BannerSinc, result: BannersResult)
}

struct BannersResult {
    let error: String?
    let banners: [Banner]?
}

struct BannerResponse: Codable {
    let data: [Banner]?
}

class BannerSinc: BasicSinc {
    var resource: Resource {
        return .banner
    }
    var queryString: String?
    
    weak var delegate: BannerSincDelegate?
    
    func responseRequest(error: ErrorRequest?, data: Data?) {
        guard error == nil else {
            if case let .errorSinc(message) = error! {
                delegate?.finishRequestBanner(banner: self, result: BannersResult(error: message, banners: nil))
            }
            return
        }
        
        guard let data = data else {
            delegate?.finishRequestBanner(banner: self, result: BannersResult(error: "error data nil", banners: nil))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let bannerData = try decoder.decode(BannerResponse.self, from: data)
            delegate?.finishRequestBanner(banner: self, result: BannersResult(error: nil, banners: bannerData.data))
        } catch {
            delegate?.finishRequestBanner(banner: self, result: BannersResult(error: "error trying to convert data to JSON", banners: nil))
            return
        }
    }
    
    func getBanners() {
        request(method: .get)
    }
}

//MARK: CategoriaSinc - Class
protocol CategoriaSincDelegate: class {
    func finishRequestCategoria(categoriaSinc: CategoriaSinc, result: CategoriasResult)
}

struct CategoriasResult {
    let error: String?
    let categorias: [Categoria]?
}

struct CategoriaResponse: Codable {
    let data: [Categoria]?
}

class CategoriaSinc: BasicSinc {
    var resource: Resource {
        return .categoria
    }
    var queryString: String?
    
    weak var delegate: CategoriaSincDelegate?
    
    func responseRequest(error: ErrorRequest?, data: Data?) {
        guard error == nil else {
            if case let .errorSinc(message) = error! {
                delegate?.finishRequestCategoria(categoriaSinc: self, result: CategoriasResult(error: message, categorias: nil))
            }
            return
        }
        
        guard let data = data else {
            delegate?.finishRequestCategoria(categoriaSinc: self, result: CategoriasResult(error: "error data nil", categorias: nil))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let categoriaData = try decoder.decode(CategoriaResponse.self, from: data)
            delegate?.finishRequestCategoria(categoriaSinc: self, result: CategoriasResult(error: nil, categorias: categoriaData.data))
        } catch {
            delegate?.finishRequestCategoria(categoriaSinc: self, result: CategoriasResult(error: "error trying to convert data to JSON", categorias: nil))
            return
        }
    }
    
    func getCategorias() {
        request(method: .get)
    }
}

//MARK:  ProdutoSinc - Class
protocol ProdutoSincDelegate: class {
    func finishRequestProduto(produtoSinc: ProdutoSinc, result: ProdutosResult)
}

struct ProdutosResult {
    let error: String?
    let produtos: [Produto]?
    let result: String?
}

struct ProdutoResponse: Codable {
    let data: [Produto]?
    let offset: Int?
    let result: String?
    let mensagem: String?
}

class ProdutoSinc: BasicSinc {
    var resource: Resource {
        return .produto
    }
    var limit: Int {
        return 20
    }
    var queryString: String?
    private var offset = 0
    
    weak var delegate: ProdutoSincDelegate?
    
    func responseRequest(error: ErrorRequest?, data: Data?) {
        guard error == nil else {
            if case let .errorSinc(message) = error! {
                delegate?.finishRequestProduto(produtoSinc: self, result: ProdutosResult(error: message, produtos: nil, result: nil))
            }
            return
        }
        
        guard let data = data else {
            delegate?.finishRequestProduto(produtoSinc: self, result: ProdutosResult(error: "error data nil", produtos: nil, result: nil))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let produtoData = try decoder.decode(ProdutoResponse.self, from: data)
            if produtoData.result != nil {
                if produtoData.result == "error" {
                    delegate?.finishRequestProduto(produtoSinc: self, result: ProdutosResult(error: produtoData.mensagem, produtos: nil, result: nil))
                } else {
                    delegate?.finishRequestProduto(produtoSinc: self, result: ProdutosResult(error: nil, produtos: nil, result: "Produto reservado com sucesso"))
                }
            } else {
                delegate?.finishRequestProduto(produtoSinc: self, result: ProdutosResult(error: nil, produtos: produtoData.data, result: nil))
            }
        } catch {
            delegate?.finishRequestProduto(produtoSinc: self, result: ProdutosResult(error: "error trying to convert data to JSON", produtos: nil, result: nil))
        }
    }
    
    func getProdutos(categoriaID: Int) {
        queryString = "?offset=\(offset)&limit=\(limit)&categoriaId=\(categoriaID)"
        request(method: .get)
    }
    
    func getProdutosMaisVendidos() {
        queryString = "/maisvendidos"
        request(method: .get)
    }
    
    func postReservaProduto(produtoID: Int) {
        queryString = "/\(produtoID)"
        request(method: .post)
    }
    
    func changeOffSet(to newValue: Int) {
        offset = newValue
    }
    
    func getOffSet() -> Int {
        return offset
    }
}
