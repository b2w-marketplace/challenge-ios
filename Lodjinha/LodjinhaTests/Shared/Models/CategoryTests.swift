//
//  CategoryTests.swift
//  LodjinhaTests
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import Lodjinha

import Quick
import Nimble

final class CategorySpec: QuickSpec {
  override func spec() {
    describe("given a valid json") {
      let bundle = Bundle(for: BannerSpec.self)
      let path = bundle.path(forResource: "Mock_Category.json", ofType: nil)!
      let url = URL(fileURLWithPath: path)
      let json = try? Data(contentsOf: url)
      context("when deserializing") {
        it("should instantiate valid Category objects") {
          let decoder = JSONDecoder()
          let result = try? decoder.decode(DataContainer<[Lodjinha.Category]>.self, from: json ?? Data())
          expect(result?.data.count).to(equal(10))
          expect(result?.data[0].description).to(equal("Games"))
          expect(result?.data[0].identifier).to(equal(1))
          expect(result?.data[0].imageUrl).to(equal(
            "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
          ))
        }
      }
    }
  }
}
