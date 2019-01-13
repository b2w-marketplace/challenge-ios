//
//  HomeViewModel.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 11/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

protocol HomeViewModelDelegate: class {
    func onBannersFetchCompleted()
    func onBannersFetchFailed()
    func onCategoriesFetchCompleted()
    func onCategoriesFetchFailed()
    func onBestSellersFetchCompleted()
    func onBestSellersFetchFailed()
}

class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?

    let sections = 3
    let request: NetworkService

    var banners: [BannerItem] = []
    var categories: [Category] = []
    var bestSellers: [Product] = []
    var isFetchingBanner = false
    var isFetchingCategories = false
    var isFetchingProducts = false

    init(request: NetworkService, delegate: HomeViewModelDelegate) {
        self.request = request
        self.delegate = delegate
    }

    func numberOfRows(for section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return bestSellers.count > 0 ? bestSellers.count : 1
        }
    }

    func getHeader(for section: Int) -> String? {
        return section == 1 ? Constants.Categories : section == 2 ? Constants.BestSellers : nil
    }

    func getHeight(for section: Int) -> CGFloat {
        if section == 0 {
            return UIScreen.main.bounds.width / 3.5 + 5
        } else if section == 1 {
            return 140
        } else {
            return 100
        }
    }

    func bestSeller(at index: Int) -> Product {
        return bestSellers[index]
    }

    func fetchBanners() {
        isFetchingBanner = true
        request.fetch(fromRoute: Routes.Banners) { (result) in
            DispatchQueue.main.async {
                self.isFetchingBanner = false
                if let bannerItems = result.value?.bannerItems, result.isSuccess {
                    self.banners = bannerItems
                    self.delegate?.onBannersFetchCompleted()
                } else {
                    self.delegate?.onBannersFetchFailed()
                }

            }
        }
    }

    func fetchCategories() {
        isFetchingCategories = true
        request.fetch(fromRoute: Routes.Categories) { (result) in
            DispatchQueue.main.async {
                self.isFetchingCategories = false
                if let categories = result.value?.categories, result.isSuccess {
                    self.categories = categories
                    self.delegate?.onCategoriesFetchCompleted()
                } else {
                    self.delegate?.onCategoriesFetchFailed()
                }
            }
        }
    }

    func fetchBestSellers() {
        isFetchingProducts = true
        request.fetch(fromRoute: Routes.BestSellers) { (result) in
            DispatchQueue.main.async {
                self.isFetchingProducts = false
                if let bestSellers = result.value?.products, result.isSuccess {
                    self.bestSellers = bestSellers
                    self.delegate?.onBestSellersFetchCompleted()
                } else {
                    self.delegate?.onBestSellersFetchFailed()
                }
            }
        }
    }
}
