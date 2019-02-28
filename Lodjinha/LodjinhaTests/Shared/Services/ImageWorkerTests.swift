//
//  ImageWorkerTests.swift
//  LodjinhaTests
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

@testable import Lodjinha

import Quick
import Nimble

final class ImageWorkerSpec: QuickSpec {
  override func spec() {
    let sut = ImageWorker()

    describe("given a image worker") {
      context("when they are asked for an image") {
        let imageUrl = "https://image.flaticon.com/icons/png/128/148/148188.png"
        it("should retrieve that image from memmory cache, disk cache or network") {
          waitUntil(timeout: 5) { done in
            sut.image(from: imageUrl) { result in
              expect(result?.1).toNot(beNil())
            }
            done()
          }
        }

        it("should have it on disk cache") {
          expect(sut.getFile(with: imageUrl)).toEventuallyNot(beNil(),
                                                              timeout: 10,
                                                              pollInterval: 1,
                                                              description: nil)
        }
      }
    }
  }
}
