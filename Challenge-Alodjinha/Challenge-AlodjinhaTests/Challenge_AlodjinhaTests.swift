//
//  Challenge_AlodjinhaTests.swift
//  Challenge-AlodjinhaTests
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import XCTest
@testable import Challenge_Alodjinha

class Challenge_AlodjinhaTests: XCTestCase {
    
    private var viewModel: HomeViewModel?
    private var viewModelList: ListProductsViewModel?
    
    private func loadBannerMock() -> BannerResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "BannerMock", withExtension: "json")!)
        do {
            let banner = try JSONDecoder().decode(BannerResponse.self, from: json)
            return banner
        } catch {
            print(error.localizedDescription)
            return BannerResponse()
        }
    }
    
    private func loadBestSellerMock() -> ProductResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "BestSellerMock", withExtension: "json")!)
        do {
            let bestSeller = try JSONDecoder().decode(ProductResponse.self, from: json)
            return bestSeller
        } catch {
            print(error.localizedDescription)
            return ProductResponse()
        }
    }
    
    private func loadCategoryMock() -> CategoryResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "CategoryMock", withExtension: "json")!)
        do {
            let category = try JSONDecoder().decode(CategoryResponse.self, from: json)
            return category
        } catch {
            print(error.localizedDescription)
            return CategoryResponse()
        }
    }
    
    private func loadProductMock() -> ProductIdResponse {
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "ProductMock", withExtension: "json")!)
        do {
            let product = try JSONDecoder().decode(ProductIdResponse.self, from: json)
            return product
        } catch {
            print(error.localizedDescription)
            return ProductIdResponse()
        }
    }
    
    func testShouldValidadeURL() {
        let url = BaseAPI().searchURL(endpoint: .banner)
        XCTAssertEqual(url, URL(string: "https://alodjinha.herokuapp.com/banner"))
    }
    
    func testShouldValidadeURLWithParameters() {
        let url = BaseAPI().searchURL(id: 1, endpoint: .product)
        XCTAssertEqual(url, URL(string: "https://alodjinha.herokuapp.com/produto?categoriaId=1"))
    }
    
    func testShouldRequestBanner() {
        let viewModel = HomeViewModel(delegate: nil, banner: loadBannerMock(), product: nil, category: nil)
        XCTAssertEqual(viewModel.banners[0].id, 1)
        XCTAssertEqual(viewModel.banners[0].linkUrl, "https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png")
        XCTAssertEqual(viewModel.banners[0].urlImagem, "https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png")
    }
    
    func testShouldValidateBestSeller() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: loadBestSellerMock(), category: nil)
        XCTAssertEqual(viewModel.products[0].id, 7)
        XCTAssertEqual(viewModel.products[0].categoria.descricao, "Games")
        XCTAssertEqual(viewModel.products[0].categoria.id, 1)
        XCTAssertEqual(viewModel.products[0].categoria.urlImagem, "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png")
        XCTAssertEqual(viewModel.products[0].descricao, "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. Não sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo é motivis de denguis.<br/><br/>Copo furadis é disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulitá. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis mé pra quem é amistosis quis leo.<br/><br/>A ordem dos tratores não altera o pão duris Delegadis gente finis, bibendum egestas augue arcu ut est. Mé faiz elementum girarzis, nisi eros vermeio. Si u mundo tá muito paradis? Toma um mé que o mundo vai girarzis!")
        XCTAssertEqual(viewModel.products[0].nome, "Fifa 17")
        XCTAssertEqual(viewModel.products[0].precoDe, 299.0)
        XCTAssertEqual(String.doubleToString(viewModel.products[0].precoPor), "119,99")
        XCTAssertEqual(viewModel.products[0].urlImagem, "https://images-submarino.b2w.io/produtos/01/00/item/128926/4/128926443_1GG.png")
    }
    
    func testShouldValidadeNumberOfRowsBestSeller() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: loadBestSellerMock(), category: nil)
        XCTAssertEqual(viewModel.numberOfRowsBestSeller(), 11)
    }
    
    func testShouldValidadeNumberOfRowsCategory() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: nil, category: loadCategoryMock())
        XCTAssertEqual(viewModel.numberOfRowsCategory(), 10)
    }
    
    func testShouldValidadeNumberOfSection() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: loadBestSellerMock(), category: nil)
        XCTAssertEqual(viewModel.numberOfSection(), 1)
    }
    
    func testShouldValidadeDtoForImage() {
        let viewModel = HomeViewModel(delegate: nil, banner: loadBannerMock(), product: nil, category: nil)
        let dto = viewModel.dtoForImage(index: 0)
        XCTAssertEqual(dto.image, URL(string: "https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png"))
    }
    
    func testShouldValidadeDtoForRowBestSeller() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: loadBestSellerMock(), category: nil)
        let dto = viewModel.dtoForRowBestSellet(index: 0)
        XCTAssertEqual(dto.name, "Fifa 17")
        XCTAssertEqual(String.doubleToString(dto.oldValue), "299,00")
        XCTAssertEqual(String.doubleToString(dto.newValue), "119,99")
        XCTAssertEqual(dto.image, URL(string: "https://images-submarino.b2w.io/produtos/01/00/item/128926/4/128926443_1GG.png"))
    }
    
    func testShouldValidadeDtoForRowCategory() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: nil, category: loadCategoryMock())
        let dto = viewModel.dtoForRowCategory(index: 0)
        XCTAssertEqual(dto.description, "Games")
        XCTAssertEqual(dto.image, URL(string: "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"))
    }
    
    func testShouldValidadeTransporterCategory() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: nil, category: loadCategoryMock())
        XCTAssertEqual(viewModel.transporterCategory.category.count, 10)
    }
    
    func testShouldValidadeTransporterProducts() {
        let viewModel = HomeViewModel(delegate: nil, banner: nil, product: loadBestSellerMock(), category: nil)
        XCTAssertEqual(viewModel.transporterProducts.product.count, 11)
    }
    
    func testShouldValidadeNumberOfSectionList() {
        let viewModelList = ListProductsViewModel(delegate: nil, category: nil, product: loadProductMock())
        XCTAssertEqual(viewModelList.numberOfSection(), 1)
    }
    
    func testShouldValidadeNumberOfRows() {
        let viewModelList = ListProductsViewModel(delegate: nil, category: nil, product: loadProductMock())
        XCTAssertEqual(viewModelList.numberOfRows(), 25)
    }
    
    func testShouldValidadeDtoForRowsList() {
        let viewModelList = ListProductsViewModel(delegate: nil, category: nil, product: loadProductMock())
        let dto = viewModelList.dtoForRow(index: 0)
        XCTAssertEqual(dto.name, "Game Horizon Zero Down")
        XCTAssertEqual(String.doubleToString(dto.newValue), "119,99")
        XCTAssertEqual(String.doubleToString(dto.oldValue), "299,00")
        XCTAssertEqual(dto.image, URL(string: "https://images-submarino.b2w.io/produtos/01/00/item/130836/1/130836199P1.jpg"))
    }
    
    func testShouldValidateProducts() {
        let viewModelList = ListProductsViewModel(delegate: nil, category: nil, product: loadProductMock())
        XCTAssertEqual(viewModelList.product.count, 25)
    }
    
    func testShouldValidadeTransporterList() {
        let viewModelList = ListProductsViewModel(delegate: nil, category: nil, product: loadProductMock())
        XCTAssertEqual(viewModelList.transporterProducts.product.count, 25)
    }
    
    func testShouldValidadeCategory() {
        let viewModelList = ListProductsViewModel(delegate: nil, category: loadCategoryMock(), product: nil)
        XCTAssertEqual(viewModelList.categories.count, 10)
    }
}
