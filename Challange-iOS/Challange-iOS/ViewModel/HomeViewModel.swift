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
    let isSuccess = BehaviorRelay<Bool>(value: false)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let errorMsg = BehaviorRelay<String>(value: "")
    
    let pageIndex = BehaviorRelay<Int>(value: 0)
    
    func getBanners() {
        
        isLoading.accept(true)
        isSuccess.accept(true)
        errorMsg.accept("")
        
        LodjinhaAPIManager.shared.banners(failure: { (error) in
            self.isSuccess.accept(false)
            self.isLoading.accept(false)
            self.errorMsg.accept(error ?? "Algo deu errado")
        }) { (result) in
            if let banners = result?.data {
                self.banners.accept(banners)
            }
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

