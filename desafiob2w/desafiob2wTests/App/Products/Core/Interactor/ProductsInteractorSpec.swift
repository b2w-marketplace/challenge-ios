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
                it("Deve devolver uma lista produtos quando sucesso", closure: {
                    productsGateway.onError = false
                    sut.fetchProducts(idCategory: 0, completion: { (result) in
                        switch result {
                        case .success(let products):
                            expect(products.count).to(equal(32))
                        case .fail(let error):
                            expect(error).to(beNil())
                        }
                    })
                })
                
                it("Deve devolver um erro quando falhar", closure: {
                    productsGateway.onError = true
                    
                    sut.fetchProducts(idCategory: 0, completion: { (result) in
                        switch result {
                        case .success(let products):
                            expect(products).to(beNil())
                        case .fail(let error):
                            expect(error).notTo(beNil())
                        }
                    })
                    
                })
            })
        }
    }
}
