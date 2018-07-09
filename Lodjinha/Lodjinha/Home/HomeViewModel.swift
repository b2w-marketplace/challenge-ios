//
//  HomeViewModel.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

class HomeViewModel{
    private var banners = [BannerViewModel]()
    private var repository = HomeRepository()
    
    var numberOfBanners :Int {
        return banners.count
    }
    
    var listOfItems:[BannerViewModel]{
        return self.banners
    }
    
    func loadBanners(completion :@escaping  ()->Void){
        repository.getBannerList { (bannerList) in
            self.banners = bannerList.map{BannerViewModel(model: $0)}
            dump(bannerList)
            completion()
        }
    }
    
    func getBannerAtIndex(index:Int)->BannerViewModel{
        return banners[index]
    }
    
    
    
    
}
