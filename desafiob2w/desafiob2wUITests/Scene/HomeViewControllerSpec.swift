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
import OHHTTPStubs
@testable import desafiob2w

class HomeViewControllerSpec: KIFSpec {
    override func spec() {
        var sut: HomeViewController!
        describe("") {
            context("", {
                beforeEach {
                    sut = R.storyboard.home().instantiateInitialViewController() as! HomeViewController
                }
                
                it("") {
                }
            })
        }
    }
}

