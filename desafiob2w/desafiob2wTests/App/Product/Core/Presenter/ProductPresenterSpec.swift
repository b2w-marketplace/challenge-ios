//
//  ProductPresenterSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 25/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import desafiob2w
class ProductPresenterSpec: QuickSpec {
    override func spec() {
        describe("Testa a presenter de Product") {
            
            var sut: ProductPresenter!
            var viewControllerMock: ProductViewControllerMock!
            var productGatewayMock: ProductsNetworkGatewayMock!
            
            beforeEach {
                viewControllerMock = ProductViewControllerMock()
                productGatewayMock = ProductsNetworkGatewayMock()
                sut = ProductPresenter(delegate: viewControllerMock, interactor: ProductInteractor(productsGateway: productGatewayMock))
            }
            
            context("Ao chamar um produto", {
                context("Se for um sucesso", {
                    beforeEach {
                        productGatewayMock.onError = false
                        sut.getProduct(productId: 0)
                    }
                    
                    it("O Loading deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoading).to(equal(true))
                    }
                    
                    it("O Produto deve ser apresentado") {
                        expect(viewControllerMock.calledOnProduct.name).to(equal("Tv 50"))
                    }
                    
                    it("O Loading deve desaparecer") {
                        expect(viewControllerMock.calledOffLoading).to(equal(true))
                    }
                })
                
                context("Se for uma falha", {
                    beforeEach {
                        productGatewayMock.onError = true
                        sut.getProduct(productId: 0)
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
        
            context("Ao reservar um produto", {
                context("Se for um sucesso", {
                    beforeEach {
                        productGatewayMock.onError = false
                        sut.getProduct(productId: 0)
                        productGatewayMock.onError = false
                        sut.setReserveProduct()
                    }
                    
                    it("O Loading deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoading).to(equal(true))
                    }
                    
                    it("O Produto deve ser apresentado") {
                        expect(viewControllerMock.calledOnReserved).to(equal("Produto reservado com sucesso"))
                    }
                    
                    it("O Loading deve desaparecer") {
                        expect(viewControllerMock.calledOffLoading).to(equal(true))
                    }
                })
                
                context("Se for uma falha", {
                    beforeEach {
                        productGatewayMock.onError = false
                        sut.getProduct(productId: 0)
                        productGatewayMock.onError = true
                        sut.setReserveProduct()
                    }
                    
                    it("O Loading deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoading).to(equal(true))
                    }
                    
                    it("O erro deve ser apresentado") {
                        expect(viewControllerMock.calledOnReserved).to(equal("An unexpected error has occurred."))
                    }
                    
                    it("O Loading deve desaparecer") {
                        expect(viewControllerMock.calledOffLoading).to(equal(true))
                    }
                })
            })
        
        }
    }
}
