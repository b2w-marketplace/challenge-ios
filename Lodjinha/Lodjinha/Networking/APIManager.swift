//
//  APIManager.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 07/02/19.
//  Copyright © 2019 Kalivos. All rights reserved.
//

import Foundation

class APIManager: Networking {
    
    @discardableResult
    class func getBanners(onCompletion: @escaping (Result<BannerResponse>) -> Void) -> URLSessionDataTask? {
        let urlString = defaultHost.appending("banner")
        return fetchGenericData(urlString: urlString, onCompletion: { (response: Result<BannerResponse>) in
            onCompletion(response)
        })
    }
    
    @discardableResult
    class func getCategorias(onCompletion: @escaping (Result<CategoriaResponse>) -> Void) -> URLSessionDataTask? {
        let urlString = defaultHost.appending("categoria")
        return fetchGenericData(urlString: urlString, onCompletion: { (response: Result<CategoriaResponse>) in
            onCompletion(response)
        })
    }
    
    @discardableResult
    class func getProdutos(offset: Int, limit: Int, categoriaId: Int, onCompletion: @escaping (Result<ProdutoResponse>) -> Void) -> URLSessionDataTask? {
        let urlString = defaultHost.appending("produto")
        let params: [String : Any] = ["offset": offset,
                                      "limit": limit,
                                      "categoriaId": categoriaId]
        return fetchGenericData(urlString: urlString, params: params, onCompletion: { (response: Result<ProdutoResponse>) in
            onCompletion(response)
        })
    }
    
    @discardableResult
    class func getProdutosMaisVendidos(onCompletion: @escaping (Result<ProdutoResponse>) -> Void) -> URLSessionDataTask? {
        let urlString = defaultHost.appending("produto/maisvendidos")
        return fetchGenericData(urlString: urlString, onCompletion: { (response: Result<ProdutoResponse>) in
            onCompletion(response)
        })
    }
    
    @discardableResult
    class func getProdutoDetalhes(produtoId: Int, onCompletion: @escaping (Result<Produto>) -> Void) -> URLSessionDataTask? {
        let urlString = defaultHost.appending("produto/").appending("\(produtoId)")
        return fetchGenericData(urlString: urlString, onCompletion: {(response: Result<Produto>) in
            onCompletion(response)
        })
    }
    
    @discardableResult
    class func postReservarProduto(produtoId: Int, onCompletion: @escaping (Result<EmptyResponse>) -> Void) -> URLSessionDataTask? {
        let urlString = defaultHost.appending("produto/").appending("\(produtoId)")
        return fetchGenericData(urlString: urlString, httpMethod: .post, onCompletion: { (response: Result<EmptyResponse>) in
            onCompletion(response)
        })
    }
    
}
