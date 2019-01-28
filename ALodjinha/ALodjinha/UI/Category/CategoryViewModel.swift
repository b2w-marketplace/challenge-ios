//
//  CategoryViewModel.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CategoryViewModel: NSObject {
    
    let loadNextPageTrigger = PublishSubject<Void>()
    let loading = BehaviorRelay<Bool>(value: false)
    let lastPage = BehaviorRelay<Bool>(value: false)
    var pageIndex: Int = 0
    var disposeBag = DisposeBag()
    
    
    public override init() {
        super.init()
        
        loading.asObservable()
            .sample(loadNextPageTrigger)
            .flatMap { loading -> Observable<Int> in
                if loading && self.lastPage.value {
                    return Observable.empty()
                } else {
                    return Observable<Int>.create { [unowned self] observer in
                        self.pageIndex += 1
                        observer.onNext(self.pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }.subscribe(onNext: { [weak self] page in
                self?.getData(index: page)
            }).disposed(by: disposeBag)
    }
    
    var category: CategoryModel? {
        didSet {
            getData()
        }
    }
    var productArray = BehaviorRelay<[ProductModel]>(value: [])
    
    func getData(index:Int = 0) {
        loading.accept(true)
        ProductAPI.shared.getProducts(page: index, categoryId: category?.categoryId ?? 999) { (productArray) in
            if productArray.count == 0 && self.productArray.value.count > 0 {
                self.lastPage.accept(true)
            } else {
                var mutableProducts = self.productArray.value
                mutableProducts.append(contentsOf: productArray)
                self.productArray.accept(mutableProducts)
            }
            self.loading.accept(false)
        }
    }

}
