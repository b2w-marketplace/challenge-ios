//
//  ProductsPresenterSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 25/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import desafiob2w
class ProductsPresenterSpec: QuickSpec {
    override func spec() {
        describe("Testa a presenter de Products") {
            var sut: ProductsPresenter!
            var viewControllerMock: ProductsViewControllerMock!
            var productGatewayMock: ProductsNetworkGatewayMock!
            
            beforeEach {
                viewControllerMock = ProductsViewControllerMock()
                productGatewayMock = ProductsNetworkGatewayMock()
                sut = ProductsPresenter(delegate: viewControllerMock, interactor: ProductsInteractor(productsGateway: productGatewayMock))
            }
            
            context("Ao chamar os produtos", {
                context("Se for um sucesso", {
                    beforeEach {
                        productGatewayMock.onError = false
                        sut.getProducts(idCategory: 1)
                    }
                    
                    it("O Loading deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoading).to(equal(true))
                    }
                    
                    it("Os Produtos devem ser apresentados") {
                        expect(viewControllerMock.calledOnProducts.count).to(equal(40))
                    }
                    
                    it("O Loading deve desaparecer") {
                        expect(viewControllerMock.calledOffLoading).to(equal(true))
                    }
                })
                
                context("Se for uma falha", {
                    beforeEach {
                        productGatewayMock.onError = true
                        sut.getProducts(idCategory: 1)
                    }
                    
                    it("O Loading deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoading).to(equal(true))
                    }
                    
                    it("O erro deve ser apresentado") {
                        expect(viewControllerMock.calledOnError).to(matchError(NetworkError.weakConnection))
                    }
                    
                    it("O Loading deve desaparecer") {
                        expect(viewControllerMock.calledOffLoading).to(equal(true))
                    }
                })
            })
            
            context("Ao buscar o id do produto", {
                beforeEach {
                    productGatewayMock.onError = false
                    sut.getProducts(idCategory: 1)
                    
                }
                
                it("O id deve ser resgatado") {
                    expect(sut.productIdIndex(index: 1)).to(equal(5))
                }
            
            })
            
        }
    }
}
