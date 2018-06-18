//
//  ProductDetailViewModel.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 17/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit

class ProductDetailViewModel: NSObject {
    func reserveProduct(productID: String, success: @escaping() -> Void, failure: @escaping(NSError) -> Void) {
        ProductManager.reserveProduct(productID: productID, success: {
            success()
        }) { (error) in
            failure(error)
        }
    }
}
