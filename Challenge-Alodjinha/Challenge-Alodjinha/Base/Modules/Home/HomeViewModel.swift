//
//  HomeViewModel.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var banner: [Banner] = []
    private var product: [Product] = []
    private var category: [Category] = []
    
    var banners: [Banner] {
        return self.banner
    }
    
    private weak var delegate: LoadContent?
    
    init(delegate: LoadContent?) {
        self.delegate = delegate
    }
    
    func loadBanner() {
        APIRequest().loadBanner { (response) in
            if let response = response {
                self.banner = response.data
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func dtoForImage(index: Int) -> BannerViewDTO {
        let bannerView = self.banner[index]
        return BannerViewDTO(image: URL(string: bannerView.urlImagem))
    }
    
    func loadBestSeller() {
        APIRequest().loadBestSeller { response in
            if let response = response {
                self.product = response.data
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfRowsBestSeller() -> Int {
        return self.product.count
    }
    
    func dtoForRowBestSellet(index: Int) -> ProductCellDTO {
        let bestSeller = self.product[index]
        return ProductCellDTO(image: URL(string: bestSeller.urlImagem),
                              name: bestSeller.nome,
                              oldValue: bestSeller.precoDe,
                              newValue: bestSeller.precoPor)
    }
    
    func loadCategory() {
        APIRequest().loadCategory { response in
            if let response = response {
                self.category = response.data
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfRowsCategory() -> Int {
        return self.category.count
    }
    
    func dtoForRowCategory(index: Int) -> CategoryCellDTO {
        let categories = self.category[index]
        return CategoryCellDTO(image: URL(string: categories.urlImagem),
                               description: categories.descricao)
    }
}
