//
//  ProductTests.swift
//  LodjinhaTests
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import Lodjinha

import Quick
import Nimble

final class ProductSpec: QuickSpec {
  override func spec() {
    describe("given a valid json") {
      let bundle = Bundle(for: BannerSpec.self)
      let path = bundle.path(forResource: "Mock_Products.json", ofType: nil)!
      let url = URL(fileURLWithPath: path)
      let json = try? Data(contentsOf: url)
      context("when deserializing") {
        it("should instantiate valid Product objects") {
          let decoder = JSONDecoder()
          let result = try? decoder.decode(DataContainer<[Product]>.self, from: json ?? Data())
          expect(result?.data.count).to(equal(11))
          expect(result?.data[0].name).to(equal("Fifa 17"))
          expect(result?.data[0].identifier).to(equal(7))
          expect(result?.data[0].fromPrice).to(equal(299))
          expect(result?.data[0].toPrice).to(equal(119.99))
        }
      }
    }
  }
}
