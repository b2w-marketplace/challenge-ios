//
//  ProductsGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

protocol ProductsGateway {
    func products(url: String, completionHandler: @escaping CompletionHandler<[Product], NetworkError>)
}
