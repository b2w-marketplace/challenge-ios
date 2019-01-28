//
//  ProductViewModel.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProductViewModel: NSObject {
    
    var product = BehaviorRelay<ProductModel>(value: ProductModel())
    var response = BehaviorRelay<(success: Bool, message: String)>(value: (false, ""))
    
    func preOrderProduct() {
        ProductAPI.shared.preOrderProduct(productId: product.value.productId) { (response) in
            self.response.accept(response)
        }
    }

}
