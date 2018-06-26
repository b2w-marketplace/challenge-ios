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
                
                context("Se a chamada for um sucesso", {
                    var products: [Product]?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "ProdutosMaisVendidos", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        sut.bestSellerProducts(url: fakeApiPath, completionHandler: { (result) in
                            if case let .success(newProducts) = result {
                                products = newProducts
                            }
                        })
                    }
                    it("Deve devolver uma lista dos produtos mais vendidos", closure: {
                        expect(products?.count).toEventually(equal(11))
                        expect(products?.first?.name).toEventually(equal("Fifa 17"))
                        expect(products?.first?.id).toEventually(equal(7))
                    })
                })
            
                context("Se a chamada falhar", {
                    var error: NetworkError?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                                .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                        })
                        sut.bestSellerProducts(url: fakeApiPath, completionHandler: { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve retornar um erro", closure: {
                        expect(error).toEventuallyNot(beNil())
                    })
                })
            })
            
            context("Ao buscar um produto", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
                
                context("Se a chamada for um sucesso", {
                    var product: Product?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "Produto", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        sut.product(url: fakeApiPath, idProduct: 27, completionHandler: {  (result) in
                            if case let .success(newProduct) = result {
                                product = newProduct
                            }
                        })
                    }
                    it("Deve retornar um produto", closure: {
                        expect(product?.name).toEventually(equal("Resident Evil"))
                        expect(product?.priceFrom).toEventually(equal(299))
                        expect(product?.priceTo).toEventually(equal(119.99))
                    })
                })
                
                context("Se a chamada falhar", {
                    var error: NetworkError?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                                .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                        })
                        sut.product(url: fakeApiPath, idProduct: 0, completionHandler: { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve retornar um erro", closure: {
                        expect(error).toEventuallyNot(beNil())
                    })
                })
            })
            
            context("Ao buscar a lista de produtos", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
            
                context("Se a chamada for um sucesso", {
                    var products: [Product]?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "Produtos", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        sut.products(url: fakeApiPath, offset: 0, limit: 20, idCategory: 0, completionHandler: { (result) in
                            if case let .success(newProducts) = result {
                                products = newProducts
                            }
                        })
                    }
                    it("Deve retornar um produto", closure: {
                        expect(products?.count).toEventually(equal(10))
                        expect(products?.first?.name).toEventually(equal("HTML e CSS"))
                        expect(products?.first?.id).toEventually(equal(41))
                    })
                })
                
                context("Se a chamada falhar", {
                    var error: NetworkError?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                                .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                        })
                        sut.products(url: fakeApiPath, offset: 0, limit: 20, idCategory: 0, completionHandler: { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve retornar um erro", closure: {
                        expect(error).toEventuallyNot(beNil())
                    })
                })
            })
            
            context("Ao reservar um produto", {
                let bundle = Bundle(for: ProductsNetworkGatewaySpec.self)
                
                context("Se a chamada for um sucesso", {
                    var reserve: Bool?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "Reserva", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        sut.reserveProduct(url: fakeApiPath, idProduct: 0, completionHandler: { (result) in
                            if case let .success(newReserve) = result {
                                reserve = newReserve
                            }
                        })
                    }
                    it("Deve retornar uma mensagem de sucesso", closure: {
                        expect(reserve).toEventually(equal(true))
                    })
                })
                
                context("Se a chamada falhar", {
                    var error: NetworkError?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                                .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                        })
                        sut.reserveProduct(url: fakeApiPath, idProduct: 0, completionHandler: { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve retornar um erro", closure: {
                        expect(error).toEventuallyNot(beNil())
                    })
                })
            })
        }
    }
}
