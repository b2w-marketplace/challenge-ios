//
//  HomeViewControllerSpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Nimble_Snapshots
import Quick
import Nimble

@testable import desafiob2w
class HomeViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: HomeViewController!
        describe("") {
            context("", {
                beforeEach {
                    sut = R.storyboard.home().instantiateInitialViewController() as! HomeViewController
                    let productsGateway = ProductsNetworkGatewayMock()
                    let bannersGateway = BannersNetworkGatewayMock()
                    let categoriesGateway = CategoriesNetworkGatewayMock()
                    let interactor = HomeInteractor(categoriesGateway: categoriesGateway, productsGateway: productsGateway, bannersGateway: bannersGateway)
                    sut.presenter = HomePresenter(delegate: sut, interactor: interactor)
                }
                
                it("") {
                    expect(sut) == recordSnapshot("SanpHomeViewController")
                }
            })
        }
    }
}
