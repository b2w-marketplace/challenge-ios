//
//  APIResultTests.swift
//  LodjinhaTests
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import Lodjinha

import Quick
import Nimble

final class APIResultSpec: QuickSpec {
  override func spec() {
    describe("given a valid json") {
      let bundle = Bundle(for: BannerSpec.self)
      let path = bundle.path(forResource: "Mock_APIResult.json", ofType: nil)!
      let url = URL(fileURLWithPath: path)
      let json = try? Data(contentsOf: url)
      context("when deserializing") {
        it("should instantiate valid APIResult object") {
          let decoder = JSONDecoder()
          let result = try? decoder.decode(APIResult.self, from: json ?? Data())
          expect(result?.result).to(equal("error"))
          expect(result?.message).to(equal("Produto não encontrado"))
        }
      }
    }
  }
}
