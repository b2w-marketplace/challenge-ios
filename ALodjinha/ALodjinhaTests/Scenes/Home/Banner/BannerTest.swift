//
//  HomeTest.swift
//  ALodjinhaTests
//
//  Created by Luis Ferreira on 07/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import XCTest
@testable import ALodjinha

class BannerTest: XCTestCase {

    var viewModel: HomeViewModel?
    
    override func setUp() {
        viewModel = HomeViewModel(delegate: nil, banners: loadBannerMock(), categories: nil, bestSeller: nil)
    }
    
    private func loadBannerMock() -> BannerResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "BannerMock", withExtension: "json")!)
        do {
            let banner = try JSONDecoder().decode(BannerResponse.self, from: json)
            return banner
        } catch {
            print(error.localizedDescription)
            return BannerResponse()
        }
    }
    
    func testShouldNumberOfSections() {
        XCTAssertEqual(viewModel?.numberOfSections(), 3)
    }
    
    func testShouldTitleForHeader() {
        XCTAssertEqual(viewModel?.titleForHeader(section: 0), "")
    }
    
    func testShouldDefaultTitleHeader() {
        XCTAssertEqual(viewModel?.titleForHeader(section: 3), "")
    }

    func testShloudNumberOfRows() {
        XCTAssertEqual(viewModel?.numberOfRows(section: 0), 1)
    }
    
    func testShouldBanners() {
        let banner = viewModel?.banners[2]
        XCTAssertEqual(banner?.urlImagem, "https://images-submarino.b2w.io/spacey/2017/02/03/sub-home-dest-full-655x328-touch-play.png")
    }
    
    func testShouldBannerURL() {
        XCTAssertEqual(APIConfiguration().searchUrl(id: nil, offset: nil, endpoint: .banner), URL(string: "https://alodjinha.herokuapp.com/banner"))    }
}
