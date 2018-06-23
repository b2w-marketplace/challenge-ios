//
//  ProductsNetworkGatewaySpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 22/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import desafiob2w

class ProductsNetworkGatewaySpec: QuickSpec {
    override func spec() {
        describe("Testes de requisição de produtos") {
            var sut: ProductsGateway!
            let host = "www.submarino.com.br"
            let fakeApiPath = "https://\(host)/"
            beforeEach {
                sut = ProductsNetworkGatewayFactory.make()
            }
            
            context("Ao buscar os produtos mais vendidos", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
                
                it("Deve retornar uma lista de produtos quando a requisição for sucesso", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        let fixturePath = bundle.path(forResource: "ProdutosMaisVendidos", ofType: "json")!
                        return fixture(filePath: fixturePath, status: 200, headers: nil)
                    })
                    
                    var products: [Product]?
                    sut.bestSellerProducts(url: fakeApiPath, completionHandler: { (result) in
                        switch result {
                        case .success(let productsResult):
                            products = productsResult
                        default: break
                        }
                    })
                    expect(products?.count).toEventually(equal(11))
                    expect(products?.first?.name).toEventually(equal("Fifa 17"))
                    expect(products?.first?.id).toEventually(equal(7))
                })
                
                it("Deve retornar um erro quando a requisição for uma falha", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                            .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                    })
                    
                    var error: NetworkError?
                    sut.bestSellerProducts(url: fakeApiPath, completionHandler: { (result) in
                        switch result {
                        case .fail(let errorResult):
                            error = errorResult
                        default: break
                        }
                    })
                    expect(error).toEventuallyNot(beNil())
                })

            })
            
            context("Ao buscar um produto", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
                it("Deve retornar um produto quando a requisição for um sucesso", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        let fixturePath = bundle.path(forResource: "Produto", ofType: "json")!
                        return fixture(filePath: fixturePath, status: 200, headers: nil)
                    })
                    var product: Product?
                    sut.product(url: fakeApiPath, idProduct: 27, completionHandler: {  (result) in
                        switch result {
                        case .success(let productResult):
                            product = productResult
                        default: break
                        }
                    })
                    
                    expect(product?.name).toEventually(equal("Resident Evil"))
                    expect(product?.priceFrom).toEventually(equal(299))
                    expect(product?.priceTo).toEventually(equal(119.99))
                })
                
                it("Deve retornar um erro quando a requisição for uma falha", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                            .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                    })
                    
                    var error: NetworkError?
                    sut.product(url: fakeApiPath, idProduct: 0, completionHandler: {  (result) in
                        switch result {
                        case .fail(let errorResult):
                            error = errorResult
                        default: break
                        }
                    })
                    expect(error).toEventuallyNot(beNil())
                })
            })
            
            context("Ao buscar a lista de produtos", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
                it("Deve retornar uma lista de produtos quando a requisição for um sucesso", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        let fixturePath = bundle.path(forResource: "Produtos", ofType: "json")!
                        return fixture(filePath: fixturePath, status: 200, headers: nil)
                    })
                    var products: [Product]?
                    sut.products(url: fakeApiPath, offset: 0, limit: 20, idCategory: 0, completionHandler: { (result) in
                        switch result {
                        case .success(let productsResult):
                            products = productsResult
                        default: break
                        }
                    })
                    expect(products?.count).toEventually(equal(10))
                    expect(products?.first?.name).toEventually(equal("HTML e CSS"))
                    expect(products?.first?.id).toEventually(equal(41))
                })
                
                it("Deve retornar um erro quando a requisição falha", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                            .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                    })
                    
                    var error: NetworkError?
                    sut.products(url: fakeApiPath, offset: 0, limit: 20, idCategory: 0, completionHandler: { (result) in
                        switch result {
                        case .fail(let errorResult):
                            error = errorResult
                        default: break
                        }
                    })
                    expect(error).toEventuallyNot(beNil())
                })
            })
            
            context("Ao reservar um produto", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
                it("Deve retornar sucesso quando a requisição for um sucesso", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        let fixturePath = bundle.path(forResource: "Reserva", ofType: "json")!
                        return fixture(filePath: fixturePath, status: 200, headers: nil)
                    })
                    
                    var reserva: Bool?
                    sut.reserveProduct(url: fakeApiPath, idProduct: 0, completionHandler: { (result) in
                        switch result {
                        case .success(let reservaResult):
                            reserva = reservaResult
                        default: break
                        }
                    })
                    
                    expect(reserva).toEventually(equal(true))
                })
                
                it("Deve retornar um erro quando a requisição for uma falha", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                            .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                    })
                    
                    var error: NetworkError?
                    sut.reserveProduct(url: fakeApiPath, idProduct: 0, completionHandler: { (result) in
                        switch result {
                        case .fail(let errorResult):
                            error = errorResult
                        default: break
                        }
                    })
                    expect(error).toEventuallyNot(beNil())
                })
            })
        }
    }
}
