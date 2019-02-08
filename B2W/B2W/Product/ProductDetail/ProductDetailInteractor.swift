//
//  ProductDetailInteractor.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class ProductDetailInteractor: NSObject {
    let loadingPresenter = LoadingPresenter()
    
    func bookProduct(productId: String, successHandler: @escaping () -> ()){
        loadingPresenter.showLoading()
        
        ProductClient().postProductBook(productId: productId, successHandler: {
            self.loadingPresenter.hideLoading()
            
            if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let alert = UIAlertController(title: "", message: kProductBookSuccess, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: kProductBookConfirm, style: .default, handler: { action in
                    successHandler()
                }))
                navigation.present(alert, animated: true, completion: nil)
            }
        }) { error, isCancelled in
            self.loadingPresenter.hideLoading()
            
            if let navigation = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
                let alert = UIAlertController(title: "", message: kProductBookError, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: kProductBookConfirm, style: .default, handler: { action in
                    successHandler()
                }))
                navigation.present(alert, animated: true, completion: nil)
            }
        }
    }
}
