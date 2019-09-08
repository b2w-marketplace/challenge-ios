//
//  BestSellerTest.swift
//  ALodjinhaTests
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import XCTest
@testable import ALodjinha

class BestSellerTest: XCTestCase {

    var viewModel: HomeViewModel?

    override func setUp() {
        viewModel = HomeViewModel(delegate: nil, banners: nil, categories: nil, bestSeller: loadBestSeller())
    }
    
    private func loadBestSeller() -> BestSellerResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "BestSellerMock", withExtension: "json")!)
        do {
            let bestSeller = try JSONDecoder().decode(BestSellerResponse.self, from: json)
            return bestSeller
        } catch {
            print(error.localizedDescription)
            return BestSellerResponse()
        }
    }
    
    func testShouldNumberOfRows() {
        XCTAssertEqual(viewModel?.numberOfRows(section: 2), 11)
    }
    
    func testShouldDtoForRows() {
        let index = viewModel?.dtoForRows(indexPath: IndexPath(row: 0, section: 2))
        XCTAssertEqual(index?.name, "Fifa 17")
        XCTAssertEqual(index?.priceDe, 299.0)
        XCTAssertEqual(index?.pricePor, 119.99)
    }
    
    func testShouldTransporter() {
        let index = viewModel?.productTransporter(indexPath: IndexPath(row: 0, section: 2))
        XCTAssertEqual(index?.id, 7)
        XCTAssertEqual(index?.categoria.id, 1)
    }
}
