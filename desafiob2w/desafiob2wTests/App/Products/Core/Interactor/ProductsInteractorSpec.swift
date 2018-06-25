//
//  ProductsInteractorSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import desafiob2w
class ProductsInteractorSpec: QuickSpec {
    override func spec() {
        describe("Testa Interactor dos produtos") {
            var sut: ProductsInteractor!
            let productsGateway = ProductsNetworkGatewayMock()
            
            beforeEach {
                sut = ProductsInteractor(productsGateway: productsGateway)
            }
            
            context("Ao chamar a lista de produtos", {
                context("Ao retornar produtos") {
                    productsGateway.onError = false
    
                    var products: [Product]!
                    beforeEach {
                        sut.fetchProducts(idCategory: 0, completion: { (result) in
                            if case let .success(newProducts) = result {
                                products = newProducts
                            }
                        })
                    }
                    
                    it("Deve devolver uma lista produtos quando sucesso", closure: {
                        expect(products.count) == productsGateway.productsStub.count
                        expect(productsGateway.offset) == 0
                    })
                    
                    context("Ao chamar a lista de produtos") {
                        beforeEach {
                            sut.fetchProducts(idCategory: 0, completion: { (result) in
                                if case let .success(newProducts) = result {
                                    products = newProducts
                                }
                            })
                        }
                        
                        it("Deve passar o offset correto") {
                            expect(productsGateway.offset) == productsGateway.productsStub.count
                        }
                    }
                }
                
                context("Ao retornar erro") {
                    var error: Error?
                    beforeEach {
                        productsGateway.onError = true
                        sut.fetchProducts(idCategory: 0) { (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        }
                    }
                    
                    it("Deve devolver um erro quando falhar") {
                        expect(error).notTo(beNil())
                    }
                }
            })
        }
    }
}
