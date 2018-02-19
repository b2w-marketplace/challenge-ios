//
//  GenerateURLTest.swift
//  LojinhaTests
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import Lojinha

class GenerateURLTest: QuickSpec
{
    override func spec()
    {
        describe("Generate URL")
        {
            context("after initialize by Banner Type")
            {
                let newURL = GenerateURL.get(type: .banner)
                
                it("should not be nil")
                {
                    expect(newURL).toNot(beNil())
                }
                
                it("should be a Sring")
                {
                    expect(newURL).to(beAKindOf(String.self))
                }
                
                it("should have the string URL to request Banner")
                {
                    expect(newURL).to(equal("https://alodjinha.herokuapp.com/banner"))
                }
            }
            
            context("after initialize by Category Type")
            {
                let newURL = GenerateURL.get(type: .category)
                
                it("should not be nil")
                {
                    expect(newURL).toNot(beNil())
                }
                
                it("should be a Sring")
                {
                    expect(newURL).to(beAKindOf(String.self))
                }
                
                it("should have the string URL to request Category")
                {
                    expect(newURL).to(equal("https://alodjinha.herokuapp.com/categoria"))
                }
            }
            
            context("after initialize by Product Type")
            {
                let newURL = GenerateURL.get(type: .product)
                
                it("should not be nil")
                {
                    expect(newURL).toNot(beNil())
                }
                
                it("should be a Sring")
                {
                    expect(newURL).to(beAKindOf(String.self))
                }
                
                it("should have the string URL to request Product")
                {
                    expect(newURL).to(equal("https://alodjinha.herokuapp.com/produto/"))
                }
            }
            
            context("after initialize by ProductByCategory Type")
            {
                let newURL = GenerateURL.get(type: .productByCategory)
                
                it("should not be nil")
                {
                    expect(newURL).toNot(beNil())
                }
                
                it("should be a Sring")
                {
                    expect(newURL).to(beAKindOf(String.self))
                }
                
                it("should have the string URL to request ProductByCategory")
                {
                    expect(newURL).to(equal("https://alodjinha.herokuapp.com/produto?offset=0&limit=20&categoriaId="))
                }
            }
            
            context("after initialize by TopSellingProduct Type")
            {
                let newURL = GenerateURL.get(type: .topSellingProducts)
                
                it("should not be nil")
                {
                    expect(newURL).toNot(beNil())
                }
                
                it("should be a Sring")
                {
                    expect(newURL).to(beAKindOf(String.self))
                }
                
                it("should have the string URL to request TopSellingProduct")
                {
                    expect(newURL).to(equal("https://alodjinha.herokuapp.com/produto/maisvendidos"))
                }
            }
            
            context("after initialize by ReserveProduct Type")
            {
                let newURL = GenerateURL.get(type: .reserveProduct)
                
                it("should not be nil")
                {
                    expect(newURL).toNot(beNil())
                }
                
                it("should be a Sring")
                {
                    expect(newURL).to(beAKindOf(String.self))
                }
                
                it("should have the string URL to request ReserveProduct")
                {
                    expect(newURL).to(equal("https://alodjinha.herokuapp.com/produto/"))
                }
            }
        }
    }
    
}

