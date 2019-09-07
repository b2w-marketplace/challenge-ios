//
//  HomeViewModel.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation

struct Section {
    let sections = ["", "Categorias", "Mais vendidos"]
}

class HomeViewModel {
    
    private var bannerResponse = BannerResponse()
    private var categoriesResponse = CategoriesResponse()
    private var bestSellerResponse = BestSellerResponse()
    private weak var delegate: LoadContentable?
    
    var banners: [Banner] {
        return self.bannerResponse.data
    }
    
    var category: [Category] {
        return self.categoriesResponse.data
    }
    
    init(delegate: LoadContentable?) {
        self.delegate = delegate
    }
    
    func loadBanner() {
        APIRequest().bannerRequest { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                self.bannerResponse = response
            }
            self.delegate?.didLoad()
        }
    }
    
    func loadCategories() {
        APIRequest().categoriesRequest { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                self.categoriesResponse = response
            }
            self.delegate?.didLoad()
        }
    }
    
    func loadBestSeller() {
        APIRequest().bestSellerRequest { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                self.bestSellerResponse = response
            }
            self.delegate?.didLoad()
        }
    }
    
    func numberOfSections() -> Int {
        return Section().sections.count
    }
    
    func titleForHeader(section: Int) -> String {
        switch section {
        case 0:
            return Section().sections[section]
        case 1:
            return Section().sections[section]
        case 2:
            return Section().sections[section]
        default:
            return ""
        }
    }
    
    func numberOfRows(section: Int) -> Int {
        switch section {
        case 2:
            return self.bestSellerResponse.data.count
        default:
            return 1
        }
    }
    
    func dtoForRows(indexPath: IndexPath) -> ProductCellDTO {
        let dto = bestSellerResponse.data[indexPath.row]
        return ProductCellDTO(name: dto.nome,
                              image: dto.urlImagem,
                              priceDe: dto.precoDe,
                              pricePor: dto.precoPor)
    }
    
    func productTransporter(indexPath: IndexPath) -> Product {
        return self.bestSellerResponse.data[indexPath.row]
    }
}
