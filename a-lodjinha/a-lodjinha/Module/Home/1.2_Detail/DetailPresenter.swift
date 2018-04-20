//
//  DetailPresenter.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/20/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation

protocol DetailPresenterDelegate: class {
}

class DetailPresenter {
    
    weak var delegate: DetailPresenterDelegate?
    private var router: DetailRouter
    
    //Initialize dependences here
    init(router: DetailRouter) {
        self.router = router
    }

}
