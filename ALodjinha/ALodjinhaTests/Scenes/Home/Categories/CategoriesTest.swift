//
//  CategoriesTest.swift
//  ALodjinhaTests
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import XCTest
@testable import ALodjinha

class CategoriesTest: XCTestCase {

    var viewModel: HomeViewModel?
    
    override func setUp() {
        viewModel = HomeViewModel(delegate: nil, banners: nil, categories: loadCategoriesMock(), bestSeller: nil)
    }

    private func loadCategoriesMock() -> CategoriesResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "CategoriesMock", withExtension: "json")!)
        do {
            let category = try JSONDecoder().decode(CategoriesResponse.self, from: json)
            return category
        } catch {
            print(error.localizedDescription)
            return CategoriesResponse()
        }
    }
    
    func testShouldcategories() {
        let category = viewModel?.category[0]
        XCTAssertEqual(category?.id, 1)
        XCTAssertEqual(category?.descricao, "Games")
    }
}
