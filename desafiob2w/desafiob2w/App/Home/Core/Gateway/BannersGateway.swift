//
//  BannersGateway.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

protocol BannersGateway {
    func banners(url: String, completionHandler: @escaping CompletionHandler<[Banner], NetworkError>)
}
