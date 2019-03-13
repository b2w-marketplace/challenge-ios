//
//  ProductInfoPresenter.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 12/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

protocol ProductInfoPresenterDelegate: class {
    func setLoading(loading: Bool)
    func showReserveAlert(reserved: Bool, message: String)
}

class ProductInfoPresenter: NSObject {
    var product: ProductModel?
    weak var delegate: ProductInfoPresenterDelegate?
    
    var photoUrl: URL? {
        return product?.imageUrl
    }
    
    var productName: String? {
        return product?.name
    }
    
    var oldPriceText: NSAttributedString? {
        guard let oldPrice = product?.oldPrice else {
            return nil
        }
        
        let formattedString = String(format: "De %.2f", oldPrice)
        let oldPriceAttrString = NSAttributedString(string: formattedString, attributes: [.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        return oldPriceAttrString
    }
    
    var newPriceString: String? {
        guard let newPrice = self.product?.newPrice else {
            return nil
        }
        return String(format: "Por %.2f", newPrice)
    }
    
    var productDescription: NSAttributedString? {
        guard let description = self.product?.description,
            let htmlStringData = description.data(using: String.Encoding.unicode) else {
            return nil
        }
        
        let htmlString = try? NSAttributedString(data: htmlStringData, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        return htmlString
    }
    
    
    // MARK: - Reserve
    func reserveProduct() {
        guard let productId = self.product?.id else {
            return
        }
        
        self.delegate?.setLoading(loading: true)
        LodjinhaAPI.reserveProduct(productId: productId) {[weak self] (success) in
            self?.delegate?.setLoading(loading: false)
            
            let message = success ? "Produto reservado com sucesso!" : "Problemas ao realizar a reserva do produto. Tente novamente mais tarde."
            self?.delegate?.showReserveAlert(reserved: success, message: message)
        }
    }
}
