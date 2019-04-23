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
    
    func viewDidLoad() {
        loadBanners()
        loadCategories()
        loadTopSellingProductListObservable()
    }
    
    func loadBanners() {
        interactor.bannesObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] bannerList in
                self?.view.setup(bannerList: bannerList)
            }, onError: { [weak self] error in
                self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    func loadCategories() {
        interactor.categoriesObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] categoryList in
                self?.view.setup(categoryList: categoryList)
            }, onError: { [weak self] error in
                self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    func loadTopSellingProductListObservable() {
        interactor.topSellingProductListObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] topSellingProductList in
                self?.view.setup(topSellingProductList: topSellingProductList)
            }, onError: { [weak self] error in
                self?.view.showAlert(message: String(identifier: .serviceErrorMessage))
            })
            .disposed(by: disposeBag)
    }
    
    func didSelectCategory(category: Category) {
        router.presentProductListScreen(category: category)
    }
    
    func didSelectProduct(product: Product) {
        router.presentProductDetailScreen(product: product)
    }
    
}
