//
//  APITests.swift
//  APITests
//
//  Created by Victor Hideki Rezende Takai on 26/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import XCTest
@testable import Lodjinha

class APIManagerTests: XCTestCase {

    func testGetBanners() {
        let expectation = self.expectation(description: "GetBanners")
        var banners: [Banner]?
        
        APIManager.getBanners { (response) in
            switch response {
            case .success(_, let result):
                banners = result.data
            case .error:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(banners)
    }
    
    func testGetCategorias() {
        let expectation = self.expectation(description: "GetCategorias")
        var categorias: [Categoria]?
        
        APIManager.getCategorias { (response) in
            switch response {
            case .success(_, let result):
                categorias = result.data
            case .error:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(categorias)
    }
    
    func testGetProdutos() {
        let expectation = self.expectation(description: "GetProdutos")
        var produtos: [Produto]?
        
        APIManager.getProdutos(offset: 0, limit: 10, categoriaId: 1) { (response) in
            switch response {
            case .success(_, let result):
                produtos = result.data
            case .error:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(produtos)
    }
    
    func testGetProdutosMaisVendidos() {
        let expectation = self.expectation(description: "GetProdutosMaisVendidos")
        var produtos: [Produto]?
        
        APIManager.getProdutosMaisVendidos { (response) in
            switch response {
            case .success(_, let result):
                produtos = result.data
            case .error:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(produtos)
    }
    
    func testGetProdutoDetalhes() {
        let expectation = self.expectation(description: "GetProdutosMaisVendidos")
        var produto: Produto?
        
        APIManager.getProdutoDetalhes(produtoId: 1) { (response) in
            switch response {
            case .success(_, let result):
                produto = result
            case .error:
                break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(produto)
    }
    
    func testPostReservarProduto() {
        let expectation = self.expectation(description: "PostReservarProduto")
        var returnedValue: Bool?
        
        APIManager.postReservarProduto(produtoId: 1) { (response) in
            switch response {
            case .success:
                returnedValue = true
            case .error:
                returnedValue = false
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(returnedValue)
    }

}
