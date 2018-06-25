//
//  HomeViewControllerSpec.swift
//  desafiob2wUiTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import KIF_Quick
import Quick
@testable import desafiob2w

class HomeViewControllerSpec: KIFSpec {
    override func spec() {
        var sut: HomeViewController!
        describe("Testa fluxo da home") {
            context("Ao acessar a home", {
                beforeEach {
                    sut = R.storyboard.home().instantiateInitialViewController() as! HomeViewController
                    let productsGateway = ProductsNetworkGatewayMock()
                    let bannersGateway = BannersNetworkGatewayMock()
                    let categoriesGateway = CategoriesNetworkGatewayMock()
                    
                    let interactor = HomeInteractor(categoriesGateway: categoriesGateway, productsGateway: productsGateway, bannersGateway: bannersGateway)
                    sut.presenter = HomePresenterFactory.make(delegate: sut, interactor: interactor)
                }
                
                it("") {
                    viewTester().usingIdentifier("HomeViewController")
                }
            })
        }
    }
}
