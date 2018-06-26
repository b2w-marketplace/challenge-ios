//
//  HomePresenterSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 25/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import desafiob2w
class HomePresenterSpec: QuickSpec {
    override func spec() {
        describe("Testa presenter da Home") {
            var sut: HomePresenter!
            var viewControllerMock: HomeViewControllerMock!
            var productGatewayMock: ProductsNetworkGatewayMock!
            var categoiesGatewayMock: CategoriesNetworkGatewayMock!
            var bannersGatewayMock: BannersNetworkGatewayMock!
        
            beforeEach {
                viewControllerMock = HomeViewControllerMock()
                productGatewayMock = ProductsNetworkGatewayMock()
                categoiesGatewayMock = CategoriesNetworkGatewayMock()
                bannersGatewayMock = BannersNetworkGatewayMock()
                sut = HomePresenter(delegate: viewControllerMock, interactor: HomeInteractor(categoriesGateway: categoiesGatewayMock, productsGateway: productGatewayMock, bannersGateway: bannersGatewayMock))
            }
            
            context("Ao os chamar os banners", {
                
                context("Se for um sucesso", {
                    beforeEach {
                        bannersGatewayMock.onError = false
                        sut.getBanners()
                    }
                    it("O Loading dos bannes deve ser apresentado") {
                        expect(viewControllerMock.calledOffLoadingBanners).to(equal(true))
                    }
                    
                    it("Os banners devem ser apresentados") {
                        expect(viewControllerMock.calledOnBanners.count).to(equal(3))
                    }
                    
                    it("O Loading dos banners deve desaparecer") {
                        expect(viewControllerMock.calledOffLoadingBanners).to(equal(true))
                    }
                })
                
                context("Se for uma falha", {
                    beforeEach {
                        bannersGatewayMock.onError = true
                        sut.getBanners()
                    }
                    it("O Loading dos bannes deve ser apresentado") {
                        expect(viewControllerMock.calledOffLoadingBanners).to(equal(true))
                    }
                    
                    it("O erro deve de banners deve apresentar") {
                        expect(viewControllerMock.calledOnErrorBanners).to(matchError(NetworkError.weakConnection))
                    }
                    
                    it("O Loading dos banners deve desaparecer") {
                        expect(viewControllerMock.calledOffLoadingBanners).to(equal(true))
                    }
                })
            })
            
            context("Ao chamar as categorias", {
                context("Se for um sucesso", {
                    beforeEach {
                        categoiesGatewayMock.onError = false
                        sut.getCategories()
                    }
                    
                    it("O Loading das categorias deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoadingCategories).to(equal(true))
                    }
                    
                    it("As categorias devem ser apresentados") {
                        expect(viewControllerMock.calledOnCategories.count).to(equal(9))
                    }
                    
                    it("O Loading das categorias deve desaparecer") {
                        expect(viewControllerMock.calledOffLoadingCategories).to(equal(true))
                    }
                })
                
                context("Se for uma falha", {
                    beforeEach {
                        categoiesGatewayMock.onError = true
                        sut.getCategories()
                    }
                    
                    it("O Loading dos bannes deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoadingCategories).to(equal(true))
                    }
                    
                    it("O erro deve de banners deve apresentar") {
                        expect(viewControllerMock.calledOnErrorCategories).to(matchError(NetworkError.weakConnection))
                    }
                    
                    it("O Loading dos banners deve desaparecer") {
                        expect(viewControllerMock.calledOffLoadingCategories).to(equal(true))
                    }
                })
            })
            
            context("Ao chamar os produtos", {
                context("Se for um sucesso", {
                    beforeEach {
                        productGatewayMock.onError = false
                        sut.getProducts()
                    }
                    
                    it("O Loading das categorias deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoadingProducts).to(equal(true))
                    }
                    
                    it("As categorias devem ser apresentados") {
                        expect(viewControllerMock.calledOnProducts.count).to(equal(40))
                    }
                    
                    it("O Loading das categorias deve desaparecer") {
                        expect(viewControllerMock.calledOffLoadingProducts).to(equal(true))
                    }
                })
                
                context("Se for uma falha", {
                    beforeEach {
                        productGatewayMock.onError = true
                        sut.getProducts()
                    }
                    
                    it("O Loading das categorias deve ser apresentado") {
                        expect(viewControllerMock.calledOnLoadingProducts).to(equal(true))
                    }
                    
                    it("As categorias devem ser apresentados") {
                        expect(viewControllerMock.calledOnErrorProducts).to(matchError(NetworkError.weakConnection))
                    }
                    
                    it("O Loading das categorias deve desaparecer") {
                        expect(viewControllerMock.calledOffLoadingProducts).to(equal(true))
                    }
                })
            })
            
            context("Ao buscar o id da categoria", {
                beforeEach {
                    categoiesGatewayMock.onError = false
                    sut.getCategories()
                }
                it("O id deve ser resgatado") {
                    expect(sut.categoryIdForIndex(index: 1)).to(equal(2))
                }
            })
            
            context("Ao buscar a descrição da categoria", {
                beforeEach {
                    categoiesGatewayMock.onError = false
                    sut.getCategories()
                }
                it("A descrição deve ser resgatado") {
                    expect(sut.categoryDescriptionIndex(index: 3)).to(equal("Eletronicos"))
                }
            })
            
            context("Ao buscar o id da categoria",  {
                beforeEach {
                    productGatewayMock.onError = false
                    sut.getProducts()
                }
                
                it("O id deve ser resgatado"){
                    expect( sut.productIdForIndex(index: 4)).to(equal(1))
                }
            })
        }
    }
}
