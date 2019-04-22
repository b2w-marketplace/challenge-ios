//
//  ProducListPresenter.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import RxSwift

final class ProducListPresenter: ProducListPresenterProtocol {
    
    weak var view: ProducListViewProtocol!
    var router: ProducListRouterProtocol!
    var interactor: ProducListInteractorProtocol!
    
    private let disposeBag = DisposeBag()
    private let category: Category
    
    var title: String {
        return category.descricao
    }
    
    var currentFilter: ProductFilter {
        return ProductFilter(categoriaId: category.id)
    }
    
    var numberOfProducts: Int {
        return interactor.numberOfProducts
    }
    
    init(category: Category) {
        self.category = category
    }
    
    func viewDidLoad() {
        fetchProducts(withFilter: currentFilter)
    }
    
    func fetchProducts(withFilter filter: ProductFilter) {
        if filter.offset == 0 {
            view.showActiveIndicator()
            view.hideEmptyState()
        }
        interactor.fetchProducts(withFilter: filter)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] productList in
                if productList.count == 0 {
                    self?.view.showEmptyState()
                } else {
                    self?.view.hideEmptyState()
                }
                self?.view.hideActiveIndicator()
                self?.view.updateView()
            }, onError: { [weak self] error in
                self?.view.hideEmptyState()
                self?.view.hideActiveIndicator()
                self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    func product(at index: Int) -> Product {
        return interactor.product(at: index)
    }
    
}
