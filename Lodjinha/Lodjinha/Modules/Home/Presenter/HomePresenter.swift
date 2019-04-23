//
//  HomePresenter.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import RxSwift

final class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewProtocol!
    var router: HomeRouterProtocol!
    var interactor: HomeInteractorProtocol!
    
    private let disposeBag = DisposeBag()
    
    var bannerList: [Banner] {
        return interactor.bannerList
    }
    
    var categoryList: [Category] {
        return interactor.categoryList
    }
    
    var numberOfProducts: Int {
        return interactor.numberOfProducts
    }
    
    func viewDidLoad() {
        loadData()
    }
    
    func loadData() {
        view.showActiveIndicator()
        interactor.loadData()
            .observeOn(MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.view.hideActiveIndicator()
                self?.view.updateView()
            }, onError: { [weak self] error in
                self?.view.hideActiveIndicator()
                self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    func category(at index: Int) -> Category {
        return categoryList[index]
    }
    
    func product(at index: Int) -> Product {
        return interactor.product(at: index)
    }
    
    func didSelectCategory(category: Category) {
        router.presentProductListScreen(category: category)
    }
    
    func didSelectProduct(product: Product) {
        router.presentProductDetailScreen(product: product)
    }
    
}
