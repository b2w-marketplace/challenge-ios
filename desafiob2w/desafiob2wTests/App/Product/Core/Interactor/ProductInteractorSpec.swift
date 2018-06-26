//
//  ProductInteractorSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import desafiob2w
class ProductInteractorSpec: QuickSpec {
    override func spec() {
        describe("Testa interactor do detalhe dos produtos") {
            var sut: ProductInteractor!
            let productsGateway = ProductsNetworkGatewayMock()
            
            beforeEach {
                sut = ProductInteractor(productsGateway: productsGateway)
            }
            
            context("Ao carregar um produto", {
                
                context("Se a chamada for um sucesso", {
                    var product: Product!
                    beforeEach {
                        productsGateway.onError = false
                        sut.fetchProduct(idProduct: 0,completion: { (result) in
                            if case let .success(newProduct) = result {
                                product = newProduct
                            }
                        })
                    }
                    it("Deve devolver um produto", closure: {
                        expect(product.name).to(equal("Tv 50"))
                    })
                })
                
                context("Se a chamada falhar", {
                    var error: NetworkError!
                    beforeEach {
                        productsGateway.onError = true
                        sut.fetchProduct(idProduct: 0, completion: { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve devolver um erro", closure: {
                        expect(error).notTo(beNil())
                    })
                })
            })
            
            context("Ao reservar um produto", {
                
                context("Se a chamada for um sucesso", {
                    var isReserve: Bool!
                    beforeEach {
                        productsGateway.onError = false
                        sut.submitReserveProduct(idProduct: 0,completion: { (result) in
                            if case let .success(newIsReserve) = result {
                                isReserve = newIsReserve
                            }
                        })
                    }
                    it("Deve devolver uma mensagem de sucesso", closure: {
                        expect(isReserve).to(equal(true))
                    })
                })
                
                context("Se a chamada falhar", {
                    var error: NetworkError!
                    beforeEach {
                        productsGateway.onError = true
                        sut.submitReserveProduct(idProduct: 0, completion: { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve devolver um erro", closure: {
                        expect(error).notTo(beNil())
                    })
                })
                
            })
        }
    }
}
