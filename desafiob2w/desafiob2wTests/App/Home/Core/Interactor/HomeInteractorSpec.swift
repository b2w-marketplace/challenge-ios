//
//  HomeInteractorSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import desafiob2w
class HomeInteractorSpec: QuickSpec {
    override func spec() {
        describe("Testa Interactor da Home") {
            var sut: HomeInteractor!
            let productsGateway = ProductsNetworkGatewayMock()
            let bannersGateway = BannersNetworkGatewayMock()
            let categoriesGateway = CategoriesNetworkGatewayMock()
            
            beforeEach {
                sut = HomeInteractor(categoriesGateway: categoriesGateway, productsGateway: productsGateway, bannersGateway: bannersGateway)
            }
            
            context("Ao chamar os produtos mais vendidos", {
                
                context("Se a chamada for um sucesso", {
                    var products: [Product]!
                    beforeEach {
                        productsGateway.onError = false
                        sut.fetchProductsBestSeller(completion: { (result) in
                            if case let .success(newProducts) = result {
                                products = newProducts
                            }
                        })
                    }
                    it("Deve devolver uma lista dos produtos mais vendidos", closure: {
                        expect(products.count).to(equal(40))
                    })
                })
                
                context("Se a chamada falhar", {
                    
                    var error: NetworkError!
                    
                    beforeEach {
                        productsGateway.onError = true
                        sut.fetchProductsBestSeller(completion: { (result) in
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
            
            context("Ao chamar os banners", {
                context("Se a chamada for um sucesso", {
                    
                    var banners: [Banner]!
                    beforeEach {
                        bannersGateway.onError = false
                        sut.fetchBanners(completion: { (result) in
                            if case let .success(newBanners) = result {
                                banners = newBanners
                            }
                        })
                    }
                    it("Deve devolver uma lista dos produtos mais vendidos", closure: {
                        expect(banners.count).to(equal(3))
                    })
                })
                context("Se a chamada falhar", {
                    bannersGateway.onError = true
                    var error: NetworkError!
                    beforeEach {
                        sut.fetchBanners(completion: { (result) in
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
            
            context("Ao chamar as categorias", {
                context("Se a chamada for um sucesso", {
                    
                    var categories: [CategoryProduct]!
                    beforeEach {
                        categoriesGateway.onError = false
                        sut.fetchCategories(completion: { (result) in
                            if case let .success(newCategories) = result {
                                categories = newCategories
                            }
                        })
                    }
                    it("Deve devolver uma lista das categorias", closure: {
                        expect(categories.count).to(equal(9))
                    })
                })
            
                context("Se a chamada falhar", {
                    categoriesGateway.onError = true
                    var error: NetworkError!
                    beforeEach {
                        sut.fetchCategories(completion: { (result) in
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
