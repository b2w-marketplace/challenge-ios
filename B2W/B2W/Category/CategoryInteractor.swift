//
//  CategoryInteractor.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class CategoryInteractor: NSObject {
    var productList: Array<Product> = []
    let loadingPresenter = LoadingPresenter()
    
    func getProductListByCategory(categoryId: String, successHandler: @escaping () -> ()){
        loadingPresenter.showLoading()
        ProductClient().getProductsByCategory(categoryId: categoryId, successHandler: { productList in
            self.loadingPresenter.hideLoading()
            self.productList = productList!
            successHandler()
        }) { error, isCancelled in
            self.loadingPresenter.hideLoading()
        }
    }
}
