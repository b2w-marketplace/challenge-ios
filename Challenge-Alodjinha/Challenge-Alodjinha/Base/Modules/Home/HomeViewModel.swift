//
//  HomeViewModel.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var banner = BannerResponse()
    private var product = ProductResponse()
    private var category = CategoryResponse()
    
    var banners: [Banner] {
        return self.banner.data
    }
    
    var products: [Product] {
        return self.product.data
    }
    
    var transporterCategory: ResultTransporterCategory {
        return ResultTransporterCategory(category: category.data)
    }
    
    var transporterProducts: ResultTransporterProduct {
        return ResultTransporterProduct(product: product.data)
    }
    
    private weak var delegate: LoadContent?
    
    init(delegate: LoadContent?, banner: BannerResponse? = nil, product: ProductResponse? = nil, category: CategoryResponse? = nil) {
        self.delegate = delegate
        
        if let banner = banner {
            self.banner = banner
        }
        if let product = product {
            self.product = product
        }
        if let category = category {
            self.category = category
        }
    }
    
    func loadBanner() {
        APIRequest().loadBanner { (response) in
            if let response = response {
                self.banner = response
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func dtoForImage(index: Int) -> BannerViewDTO {
        let bannerView = self.banner.data[index]
        return BannerViewDTO(image: URL(string: bannerView.urlImagem))
    }
    
    func loadBestSeller() {
        APIRequest().loadBestSeller { response in
            if let response = response {
                self.product = response
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfRowsBestSeller() -> Int {
        return self.product.data.count
    }
    
    func dtoForRowBestSellet(index: Int) -> ProductCellDTO {
        let bestSeller = self.product.data[index]
        return ProductCellDTO(image: URL(string: bestSeller.urlImagem),
                              name: bestSeller.nome,
                              oldValue: bestSeller.precoDe,
                              newValue: bestSeller.precoPor)
    }
    
    func loadCategory() {
        APIRequest().loadCategory { response in
            if let response = response {
                self.category = response
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfRowsCategory() -> Int {
        return self.category.data.count
    }
    
    func dtoForRowCategory(index: Int) -> CategoryCellDTO {
        let categories = self.category.data[index]
        return CategoryCellDTO(image: URL(string: categories.urlImagem),
                               description: categories.descricao)
    }
}
