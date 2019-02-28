//
//  ALodjinhaAPITests.swift
//  LodjinhaTests
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import Lodjinha

import Quick
import Nimble

final class ALodjinhaAPISpec: QuickSpec {
  override func spec() {
    describe("given a lodjinha api") {
      context("fetching a banners list") {
        it("should retrieve a banners list") {
          waitUntil(timeout: 5) { done in
            ALodjinhaAPI.getBanner { callback in
              let banners = try? callback()
              expect(banners).toNot(beEmpty())
              done()
            }
          }
        }
      }

      context("fetching a categories list") {
        it("should retrieve a categories list") {
          waitUntil(timeout: 5) { done in
            ALodjinhaAPI.getCategories { callback in
              let categories = try? callback()
              expect(categories).toNot(beEmpty())
              done()
            }
          }
        }
      }

      context("fetching a bestsellers list") {
        it("should retrieve a bestsellers list") {
          waitUntil(timeout: 5) { done in
            ALodjinhaAPI.getBestsellers { callback in
              let bestsellers = try? callback()
              expect(bestsellers).toNot(beEmpty())
              done()
            }
          }
        }
      }

      context("fetching a category products list") {
        it("should retrieve a category products list") {
          waitUntil(timeout: 5) { done in
            let categoryId = 1
            ALodjinhaAPI.getProducts(with: categoryId, page: 0, perPage: 20) { callback in
              let products = try? callback()
              expect(products).toNot(beEmpty())
              expect(products![0].category.identifier).to(equal(categoryId))
              done()
            }
          }
        }
      }

      context("reserve a product") {
        it("should receive a successful response") {
          waitUntil(timeout: 5) { done in
            ALodjinhaAPI.reserveProducts(with: 1) { callback in
              do {
                try callback()
              } catch {
                fail()
              }
              done()
            }
          }
        }

        it("should receive an error response") {
          waitUntil(timeout: 5) { done in
            ALodjinhaAPI.reserveProducts(with: 9999999) { callback in
              do {
                try callback()
                fail()
              } catch {
                expect(error.localizedDescription).to(equal("Produto não encontrado"))
              }
              done()
            }
          }
        }
      }
    }
  }
}
