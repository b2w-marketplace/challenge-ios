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
                
                it("Deve devolver um produto quando sucesso", closure: {
                    productsGateway.onError = false
                    sut.fetchProduct(idProduct: 0, completion: { (result) in
                        switch result {
                        case .success(let product):
                            expect(product.name).to(equal("Tv 50"))
                        case .fail(let error):
                            expect(error).to(beNil())
                        }
                    })
                })
                
                it("Deve devolver um erro quando falhar", closure: {
                    productsGateway.onError = true
                    sut.fetchProduct(idProduct: 0, completion: { (result) in
                        switch result {
                        case .success(let product):
                            expect(product).to(beNil())
                        case .fail(let error):
                            expect(error).notTo(beNil())
                        }
                    })
                })
            })
            
            context("Ao reservar um produto", {
                it("O produto deve ser reservado quando sucesso", closure: {
                    productsGateway.onError = false
                    sut.submitReserveProduct(idProduct: 0, completion: { (result) in
                        switch result {
                        case .success(let isReserve):
                            expect(isReserve).to(equal(true))
                        case .fail(let error):
                            expect(error).to(beNil())
                        }
                    })
                })
                
                it("O produto não deve ser reservado quando falha", closure: {
                    productsGateway.onError = true
                    sut.submitReserveProduct(idProduct: 0, completion: { (result) in
                        switch result {
                        case .success(let isReserve):
                            expect(isReserve).to(beNil())
                        case .fail(let error):
                            expect(error).notTo(beNil())
                        }
                    })
                })
            })
        }
    }
}
