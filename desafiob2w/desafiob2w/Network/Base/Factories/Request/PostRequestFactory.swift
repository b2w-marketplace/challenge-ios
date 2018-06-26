//
//  PostRequestFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 20/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

enum PostRequestFactory {
    static func make() -> PostRequestable {
        return PostRequest()
    }
}
