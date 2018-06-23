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
                
                it("Deve devolver uma lista dos produtos mais vendidos quando sucesso", closure: {
                    productsGateway.onError = false
                    sut.fetchProductsBestSeller(completion: { (result) in
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
                    sut.fetchProductsBestSeller(completion: { (result) in
                        switch result {
                        case .success(let products):
                            expect(products).to(beNil())
                        case .fail(let error):
                            expect(error).notTo(beNil())
                        }
                    })
                })
                
            })
            
            context("Ao chamar os banners", {
                it("Deve devolver uma lista dos banners quando sucesso", closure: {
                    bannersGateway.onError = false

                    sut.fetchBanners(completion: { (result) in
                        switch result {
                        case .success(let banners):
                            expect(banners.count).to(equal(3))
                        case .fail(let error):
                            expect(error).to(beNil())
                        }
                    })
                })
                
                it("Deve devolver um erro quando falar ", closure: {
                    bannersGateway.onError = true
                    sut.fetchBanners(completion: { (result) in
                        switch result {
                        case .success(let products):
                            expect(products).to(beNil())
                        case .fail(let error):
                            expect(error).notTo(beNil())
                        }
                    })
                })
            })
            
            context("Ao chamar as categorias", {
                it("Deve devolver uma lista das categorias", closure: {
                    categoriesGateway.onError = false
                    sut.fetchCategories(completion: { (result) in
                        switch result {
                        case .success(let categories):
                            expect(categories.count).to(equal(9))
                        case .fail(let error):
                            expect(error).to(beNil())
                        }
                    })
                })
                
                it("Deve devolver um erro quando falhar", closure: {
                    categoriesGateway.onError = true
                    sut.fetchCategories(completion: { (result) in
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
