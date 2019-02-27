//
//  HomePresenter.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright (c) 2019 Gilson Gil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomePresentationLogic {
  func presentError(_ error: Error)
  func presentBanners(response: Home.FetchBanner.Response)
  func presentBanner(response: Home.PresentBannerLink.Response)
  func presentCategories(response: Home.FetchCategories.Response)
  func presentCategory(response: Home.PresentCategory.Response)
  func presentBestsellers(response: Home.FetchBestsellers.Response)
  func presentBestseller(response: Home.PresentBestsellers.Response)
}

final class HomePresenter: HomePresentationLogic {
  weak var viewController: HomeDisplayLogic?

  func presentError(_ error: Error) {
    viewController?.displayError(error)
  }

  func presentBanners(response: Home.FetchBanner.Response) {
    let displayedBanners = response.banners.compactMap { Home.FetchBanner.DisplayedBanner(stringUrl: $0.imageUrl) }
    let viewModel = Home.FetchBanner.ViewModel(displayedBanners: displayedBanners)
    viewController?.displayBanners(viewModel: viewModel)
  }

  func presentBanner(response: Home.PresentBannerLink.Response) {
    let link = response.banner.linkUrl
    let viewModel = Home.PresentBannerLink.ViewModel(link: link)
    viewController?.displayBannerLink(viewModel: viewModel)
  }

  func presentCategories(response: Home.FetchCategories.Response) {
    let displayedCategories = response.categories.compactMap {
      Home.FetchCategories.DisplayedCategory(description: $0.description, imageUrl: $0.imageUrl)
    }
    let viewModel = Home.FetchCategories.ViewModel(displayedCategories: displayedCategories)
    viewController?.displayCategories(viewModel: viewModel)
  }

  func presentCategory(response: Home.PresentCategory.Response) {
    let category = response.category
    let viewModel = Home.PresentCategory.ViewModel(category: category)
    viewController?.displayCategory(viewModel: viewModel)
  }

  func presentBestsellers(response: Home.FetchBestsellers.Response) {
    let displayedBestsellers: [DisplayedProduct] = response.products.compactMap {
      let fromPrice = String(format: "%@%.2f", arguments: [String.Home.priceFrom, $0.fromPrice])
      let toPrice = String(format: "%@%.2f", arguments: [String.Home.priceTo, $0.toPrice])
      return DisplayedProduct(imageUrl: $0.imageUrl,
                              name: $0.name,
                              fromPrice: fromPrice,
                              toPrice: toPrice)
    }
    let viewModel = Home.FetchBestsellers.ViewModel(displayedProducts: displayedBestsellers)
    viewController?.displayBestsellers(viewModel: viewModel)
  }

  func presentBestseller(response: Home.PresentBestsellers.Response) {
    let product = response.product
    let viewModel = Home.PresentBestsellers.ViewModel(product: product)
    viewController?.displayBestseller(viewModel: viewModel)
  }
}
