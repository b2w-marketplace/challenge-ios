//
//  HomeInteractorFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

struct HomeInteractorFactory {
    static func make() -> HomeInteractor {
        return HomeInteractor(categoriesGateway: CategoriesNetworkGatewayFactory.make(), productsGateway: ProductsNetworkGatewayFactory.make())
    }
}
