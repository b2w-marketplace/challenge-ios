//
//  ProductDetailsViewModel.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol ProductDetailsServicesDelegate: class {
    func performingReservation(loading: Bool)
    func reservationFinished()
}

protocol ProductDetailsViewModelType {
    
    var isLoading: Bool { get set }
    var reservation: Reservation? { get set}
    func productPriceBefore() -> String
    func productPriceBeforeAttributed() -> NSAttributedString?
    func productPriceNow() -> String
    func productDescription() -> String
    func productImageUrl() -> String
    func productName() -> String
    
    var productDetailsServicesDelegate: ProductDetailsServicesDelegate? { get set }
}

class ProductDetailsViewModel: ProductDetailsViewModelType {
    
    var productDetailsServicesDelegate: ProductDetailsServicesDelegate?
    var isLoading: Bool = false
    var reservation: Reservation?
    
    var service: ProductDetailsGateway!
    var product: Product
    
    init(service: ProductDetailsGateway, product: Product) {
        self.service = service
        self.product = product
    }
    
    func productName() -> String {
        return product.name
    }
    
    func productPriceNow() -> String {
        guard let priceText = formmatter().string(from: NSNumber(value: product.priceNow)) else {
            return ""
        }
        return "Por \(priceText)"
    }
    
    func productPriceBeforeAttributed() -> NSAttributedString? {
        guard let priceText = formmatter().string(from: NSNumber(value: product.priceBefore)) else {
            return nil
        }
        let text = "De \(priceText)"
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.strikethroughStyle : 1])
        return attributedString
    }
    
    func productPriceBefore() -> String {
        guard let priceText = formmatter().string(from: NSNumber(value: product.priceBefore)) else {
            return ""
        }
        return "De \(priceText)"
    }
    
    func productDescription() -> String {
        return product.description
    }
    
    func productImageUrl() -> String {
        return product.imageUrl
    }
    
    func reserveProduct() {
        productDetailsServicesDelegate?.performingReservation(loading: true)
        service.reserveProduct(productId: product.id) { [weak self] (result: Result<Reservation>) in
            
            guard let strongSelf = self else { return }
            strongSelf.productDetailsServicesDelegate?.performingReservation(loading: false)
            switch result {
            case .success(let reservation):
                strongSelf.reservation = reservation
            case .failure(_):
                strongSelf.reservation = nil
            }
        }
    }
    
    private func formmatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "pt-BR")
        return numberFormatter
    }
    
}
