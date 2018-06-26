//
//  CategoriesNetworkGatewayMock.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

@testable import desafiob2w
class CategoriesNetworkGatewayMock: CategoriesGateway {
    lazy var categoriesStub = { (0..<9).map { _ in self.category } }()
    var onError: Bool = true
    private let category = CategoryProduct(id: 2, description: "Eletronicos", urlImage: URL.init(string: "www.americanas.com.br")!)
    
    func categories(url: String, completionHandler: @escaping CompletionHandler<[CategoryProduct], NetworkError>) {
        if onError {
            completionHandler(Result.fail(NetworkError.weakConnection))
        } else {
            completionHandler(Result.success(categoriesStub))
        }
    }
}
