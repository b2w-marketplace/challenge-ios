//
//  CategoriesNetworkGatewaySpec.swift
//  desafiob2wTests
//
//  Created by Lázaro Lima dos Santos on 23/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs

@testable import desafiob2w
class CategoriesNetworkGatewaySpec: QuickSpec {
    override func spec() {
        describe("Testes de requisição de categorias") {
            var sut: CategoriesGateway!
            let host = "www.submarino.com.br"
            let fakeApiPath = "https://\(host)/"
            
            beforeEach {
                sut = CategoriesNetworkGatewayFactory.make()
            }
            
            context("Ao buscar as categorias", {
                let bundle = Bundle(for: CategoriesNetworkGatewaySpec.self)
                
                context("Se a chamada for um sucesso", {
                    var categorias: [CategoryProduct]?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "Categorias", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        sut.categories(url: fakeApiPath, completionHandler: { (result) in
                            if case let .success(newCategories) = result {
                                categorias = newCategories
                            }
                        })
                    }
                    it("Deve retornar uma lista de categorias", closure: {
                        expect(categorias?.count).toEventually(equal(10))
                        expect(categorias?.first?.id).toEventually(equal(1))
                        expect(categorias?.first?.description).toEventually(equal("Games"))
                    })
                })
                
                context("Se a chamada falhar", {
                    var error: NetworkError?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                                .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                        })
                        sut.categories(url: fakeApiPath, completionHandler: {  (result) in
                            if case let .fail(newError) = result {
                                error = newError
                            }
                        })
                    }
                    it("Deve retornar um erro", closure: {
                        expect(error).toEventuallyNot(beNil())
                    })
                })

            })
            
            
        }
    }
}
