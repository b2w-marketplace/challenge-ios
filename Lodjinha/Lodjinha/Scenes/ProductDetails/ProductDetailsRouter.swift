//
//  ProductDetailsRouter.swift
//  Lodjinha
//
//  Created by Gilson Gil on 25/02/19.
//  Copyright (c) 2019 Gilson Gil. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductDetailsRoutingLogic {
}

protocol ProductDetailsDataPassing {
  var dataStore: ProductDetailsDataStore? { get }
}

final class ProductDetailsRouter: NSObject, ProductDetailsRoutingLogic, ProductDetailsDataPassing {
  weak var viewController: ProductDetailsViewController?
  var dataStore: ProductDetailsDataStore?
}
