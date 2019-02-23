//
//  HomeInteractor.swift
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

protocol HomeBusinessLogic {
  func fetchBanner()
}

protocol HomeDataStore {
  var banners: [Banner] { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
  var presenter: HomePresentationLogic?
  lazy var worker: HomeWorker? = { HomeWorker() }()
  var banners: [Banner] = []

  func fetchBanner() {
    worker?.fetchBanner { [weak self] callback in
      do {
        let banners = try callback()
        self?.banners = banners
        let response = Home.FetchBanner.Response(banners: banners)
        self?.presenter?.presentBanners(response: response)
      } catch {
        self?.presenter?.presentError(error)
      }
    }
  }
}
