//
//  ErrorManagerTest.swift
//  LojinhaTests
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import Lojinha

class ErrorManagerTest: QuickSpec
{
    override func spec()
    {
        describe("Error manager")
        {
            context("after initialize by Unknown Type")
            {
                let typeUnknown = ErrorManager.error(type: .unknown)
                it("should not be nil")
                {
                    expect(typeUnknown).notTo(beNil())
                }
                
                it("should be a NSError")
                {
                    expect(typeUnknown).to(beAKindOf(NSError.self))
                }
                
                it("should have the matching error (Unknown)")
                {
                    expect(typeUnknown).to(equal(NSError(domain: "Não foi possível acessar no momento.", code: 404, userInfo: nil)))
                }
            }
            
            context("after initialize by Alamofire Type")
            {
                let typeAlamofire = ErrorManager.error(type: .alamofire)
                it("should not be nil")
                {
                    expect(typeAlamofire).notTo(beNil())
                }
                
                it("should be a NSError")
                {
                    expect(typeAlamofire).to(beAKindOf(NSError.self))
                }
                
                it("should have the matching error (Alamofire)")
                {
                    expect(typeAlamofire).to(equal(NSError(domain: "Erro na requisição...", code: 430, userInfo: nil)))
                }
            }
        }
    }
    
}

