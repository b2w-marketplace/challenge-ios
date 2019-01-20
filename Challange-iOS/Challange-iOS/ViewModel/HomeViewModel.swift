//
//  HomeViewModel.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher


class HomeViewModel {
    
    let banners = BehaviorRelay<[Banner]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMsg = BehaviorRelay<String>(value: "")
    
    let categories = BehaviorRelay<[Category]>(value: [])
    let isLoadingCategories = BehaviorRelay<Bool>(value: false)
    let errorMsgCategories = BehaviorRelay<String>(value: "")
    
    let mostSold = BehaviorRelay<[Products]>(value: [])
    let isLoadingMostSold = BehaviorRelay<Bool>(value: false)
    let errorMsgMostSold = BehaviorRelay<String>(value: "")
    
    let pageIndex = BehaviorRelay<Int>(value: 0)
    
    func getBanners() {
        
        isLoading.accept(true)
        errorMsg.accept("")
        
        LodjinhaAPIManager.shared.banners(failure: { (error) in
            self.isLoading.accept(false)
            self.errorMsg.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let banners = result?.data {
                self.banners.accept(banners)
            }
            self.isLoading.accept(false)
        }
    }
    
    func createImageViewBanner(width: CGFloat) -> [BannerView] {
        var bannerViews = [BannerView]()
        for banner in banners.value {
            if let urlImage = banner.urlImagem {
                let view: BannerView =  UIView.fromNib()
                view.delegate = self
                let url = URL(string: urlImage)
                let resource = ImageResource(downloadURL: url!)
                view.bannerImage.kf.setImage(with: resource)
                bannerViews.append(view)
            }
        }
        return bannerViews
    }
    
    func getCategories() {
        
        isLoadingCategories.accept(true)
        errorMsgCategories.accept("")
        
        LodjinhaAPIManager.shared.categories(failure: { (error) in
            self.isLoadingCategories.accept(false)
            self.errorMsgCategories.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let categories = result?.data {
                self.categories.accept(categories)
            }
             self.isLoadingCategories.accept(false)
        }
    }
    
    func getMostSold() {
        
        isLoadingMostSold.accept(true)
        errorMsgMostSold.accept("")
        
        LodjinhaAPIManager.shared.mostSold(failure: { (error) in
            self.isLoadingMostSold.accept(false)
            self.errorMsgMostSold.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let mostSold = result?.data {
                self.mostSold.accept(mostSold)
            }
            self.isLoadingMostSold.accept(false)
        }
    }
    
}

extension HomeViewModel: BannerTappedDelegate {
    
    func bannerTapped() {
        if let linkURL =  banners.value[pageIndex.value].linkUrl {
            if let url = URL(string: linkURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

