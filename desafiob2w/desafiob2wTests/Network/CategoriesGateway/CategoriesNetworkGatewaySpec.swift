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
                
                it("Deve retornar uma lista de categorias quando a requisição for sucesso", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        let fixturePath = bundle.path(forResource: "Categorias", ofType: "json")!
                        return fixture(filePath: fixturePath, status: 200, headers: nil)
                    })
                    
                    var categorias: [CategoryProduct]?
                    sut.categories(url: fakeApiPath, completionHandler: { (result) in
                        switch result {
                        case .success(let categoriesResult):
                            categorias = categoriesResult
                        default: break
                        }
                    })
                    expect(categorias?.count).toEventually(equal(10))
                    expect(categorias?.first?.id).toEventually(equal(1))
                    expect(categorias?.first?.description).toEventually(equal("Games"))
                    
                })
                
                it("Deve retornar um erro quando a requisição falha", closure: {
                    stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                        return OHHTTPStubsResponse(data:Data(), statusCode: 504, headers: nil)
                            .responseTime(OHHTTPStubsDownloadSpeed1KBPS)
                    })
                    
                    var error: NetworkError?
                    sut.categories(url: fakeApiPath, completionHandler: {  (result) in
                        switch result {
                        case .fail(let errorResult):
                            error = errorResult
                        default: break
                        }
                    })
                    expect(error).toEventuallyNot(beNil())
                })
            })
            
            
        }
    }
}
