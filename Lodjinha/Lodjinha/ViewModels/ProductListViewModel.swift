//
//  ProductListViewModel.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

protocol ProductListViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
    func didUpdateTotal()
}

final class ProductListViewModel {
    private weak var delegate: ProductListViewModelDelegate?

    private var products: [Product] = []
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    private var categoryId: Int

    let request: NetworkService

    init(request: NetworkService, delegate: ProductListViewModelDelegate, categoryId: Int) {
        self.request = request
        self.delegate = delegate
        self.categoryId = categoryId
    }

    var totalCount: Int {
        return total
    }

    var currentCount: Int {
        return products.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }

    func fetchProducts() {
        guard !isFetchInProgress else {
            return
        }

        isFetchInProgress = true

        request.fetch(fromRoute: Routes.Products, categoryId: categoryId, offset: currentPage, limit: currentPage + 10) {[weak self] (result) in
            guard let `self` = self else { return }
            if result.isSuccess, let productList = result.value {
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.total = productList.total
                    self.products.append(contentsOf: productList.products)
                    if productList.products.count < 10 {
                        self.total = self.products.count
                        self.delegate?.didUpdateTotal()
                    }

                    self.currentPage += 10

                    if productList.offset > 10 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: productList.products)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
            } else if result.isFailure {
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: result.error?.localizedDescription ?? "Erro desconhecido")
                }
            } else {
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: "Erro desconhecido")
                }
            }
        }

    }

    private func calculateIndexPathsToReload(from newProducts: [Product]) -> [IndexPath] {
        let startIndex = products.count - newProducts.count
        let endIndex = startIndex + newProducts.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}
