//
//  BannerTests.swift
//  LodjinhaTests
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import Lodjinha

import Quick
import Nimble

final class BannerSpec: QuickSpec {
  override func spec() {
    describe("given a valid json") {
      let bundle = Bundle(for: BannerSpec.self)
      let path = bundle.path(forResource: "Mock_Banner.json", ofType: nil)!
      let url = URL(fileURLWithPath: path)
      let json = try? Data(contentsOf: url)
      context("when deserializing") {
        it("should instantiate valid Banner objects") {
          let decoder = JSONDecoder()
          let result = try? decoder.decode(DataContainer<[Banner]>.self, from: json ?? Data())
          expect(result?.data.count).to(equal(3))
          expect(result?.data[0].linkUrl)
            .to(equal("https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png"))
          expect(result?.data[0].identifier).to(equal(1))
        }
      }
    }
  }
}
