//
//  ALodjinhaTests.swift
//  ALodjinhaTests
//
//  Created by Vinicius Andrade on 25/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import ALodjinha

class ALodjinhaTests: XCTestCase {
    
    var bannerDictionaryArray : [[String:Any]]!
    var categoryDictionaryArray : [[String:Any]]!
    var productDictionaryArray : [[String:Any]]!
    
    
    override func setUp() {
        super.setUp()
        
        bannerDictionaryArray = loadJSONFromFile("Banner")
        categoryDictionaryArray = loadJSONFromFile("Category")
        productDictionaryArray = loadJSONFromFile("Product")
    }
    
    func loadJSONFromFile(_ file: String) -> [[String: Any]] {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { return [[:]] }
        guard let data: Data = NSData(contentsOf: url) as Data? else { return [[:]] }
        
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let dictionary = object as? [String: Any] else { return [[:]] }
            guard let data = dictionary["data"] as? [[String:Any]] else { return [[:]] }
            return data
        } catch  {
            print("Not parsed")
        }
        
        return [[:]]
    }
    
    func testBannerModel() {
        let bannerArray = Mapper<BannerModel>().mapArray(JSONArray: bannerDictionaryArray)
        XCTAssert(bannerArray.count>0)
    }
    
    func testCategoryModel() {
        let categoryArray = Mapper<CategoryModel>().mapArray(JSONArray: categoryDictionaryArray)
        XCTAssert(categoryArray.count>0)
    }
    
    func testProductModel() {
        let productArray = Mapper<ProductModel>().mapArray(JSONArray: productDictionaryArray)
        XCTAssert(productArray.count>0)
    }
    
}
