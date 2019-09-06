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
            return 0
        default:
            return 1
        }
    }
}
