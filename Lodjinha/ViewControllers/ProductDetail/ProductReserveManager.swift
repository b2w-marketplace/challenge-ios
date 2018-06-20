//
//  ProductReserveManager.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Foundation
import RxSwift

class ProductReserveManager {
    
    var client: APIClient!
    
    private var reserving: [Int] = []
    
    private var disposeBag = DisposeBag()
    
    func reserveProduct(_ productId: Int) {
        
        if !reserving.contains(productId) {
            reserving.append(productId)
        }
        
        client.lodjinhaProvider.moyaRequestBodylessResponse(LodjinhaProvider.reserveProductForId(productId: productId)).subscribe(onNext: { (success) in
            if success {
                if let index = self.reserving.index(of: productId) {
                    self.reserving.remove(at: index)
                }
                NotificationCenter.default.post(name: NSNotification.Name.ReservationConfirmed, object: nil, userInfo: ["productId": productId])
            }
        }, onError: { (error) in
            if let index = self.reserving.index(of: productId) {
                self.reserving.remove(at: index)
            }
            NotificationCenter.default.post(name: NSNotification.Name.ReservationError, object: nil, userInfo: ["productId": productId])
        }).disposed(by: disposeBag)
    }
    
    func reservationConfirmed(_ productId: Int) {
        if let index = reserving.index(of: productId) {
            reserving.remove(at: index)
        }
    }
    
    func isReserving(_ productId: Int) -> Bool {
        return reserving.contains(productId)
    }
    
}
