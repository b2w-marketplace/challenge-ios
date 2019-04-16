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
    
    func dtoForImage(index: Int) -> BannerViewDTO {
        let bannerView = self.banner[index]
        return BannerViewDTO(image: URL(string: bannerView.urlImagem))
    }
}
