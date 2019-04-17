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
    
    func titleForHeaderInSection() -> [String] {
        return ["Categorias","Mais Vendidos"]
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
}
