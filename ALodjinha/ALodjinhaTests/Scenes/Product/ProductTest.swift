//
//  ProductTest.swift
//  ALodjinhaTests
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import XCTest
@testable import ALodjinha

class ProductTest: XCTestCase {

    var viewModel: ProductViewModel?
    
    override func setUp() {
        viewModel = ProductViewModel(delegate: nil, product: loadProduct())
    }
    
    private func loadProduct() -> ProductResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "ProductMock", withExtension: "json")!)
        do {
            let product = try JSONDecoder().decode(ProductResponse.self, from: json)
            return product
        } catch {
            print(error.localizedDescription)
            return ProductResponse()
        }
    }
    
    func testShouldNumberOfSections() {
        XCTAssertEqual(viewModel?.numberOfSections(), 1)
    }
    
    func testShouldNumberOfRows() {
        XCTAssertEqual(viewModel?.numberOfRows(), 6)
    }
    
    func testShouldDtoForRows() {
        let index = viewModel?.dtoForRows(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(index?.name, "Google Android")
    }
    
    func testShouldUrl() {
        XCTAssertEqual(APIConfiguration().searchUrl(id: 1, offset: 1, endpoint: .product), URL(string: "https://alodjinha.herokuapp.com/produto?offset=1&categoriaId=1"))
    }
}
