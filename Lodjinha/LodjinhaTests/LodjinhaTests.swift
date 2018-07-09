//
//  LodjinhaTests.swift
//  LodjinhaTests
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import XCTest
@testable import Lodjinha

extension XCTestCase{
    func loadStubFromBundle(withName name:String , extension:String)->Data{
        
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        return try! Data(contentsOf: url!)
    }
}


class LodjinhaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBannerJSON_Expect3Items(){
        let data = loadStubFromBundle(withName: "apiBannerData",extension: "json")
        let items = try! JSONDecoder().decode(DataBanner.self, from: data)
        XCTAssertEqual(items.data.count, 3)

    }
    
    func testCategoriaJSON_Expect10Items(){
        
        let data = loadStubFromBundle(withName: "apiCategoriaData",extension: "json")
        let items = try! JSONDecoder().decode(DataCategory.self, from: data)
        XCTAssertEqual(items.data.count, 10)
    }
    
    func testCateoriaJSON_ExpectAllValidLinks(){
        let data = loadStubFromBundle(withName: "apiCategoriaData",extension: "json")
        let items = try! JSONDecoder().decode(DataCategory.self, from: data)
        for item in items.data{
            //Alguns link estão invalidos e de acordo com a Apple, todo os links usados devem ser seguros
            if item.urlImagem.contains("https"){
                XCTAssertTrue(true)
            }else{
                XCTAssertTrue(false)

            }
        }
        
    }
    
    func testViewModelProduct(){
        let data = loadStubFromBundle(withName: "apiBestSellerData",extension: "json")
        let items = try! JSONDecoder().decode(DataBestSeller.self, from: data)
        let viewModels = items.data.map{ProudctViewModel(model: $0)}
        
        let viewModel = viewModels.first!
//        "precoDe": 299,
//        "precoPor":
        XCTAssertEqual(viewModel.priceLabel, "Por: 119.99")
        XCTAssertEqual(viewModel.discountPriceLabel,"De: 299.0")  
    }
}
