//
//  ProductDetailsGateway.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

protocol ProductDetailsGateway {
    
    func reserveProduct(productId id: Int, completion: @escaping (Result<Reservation>) -> Void)
}

class ProductDetailsService: ProductDetailsGateway {
    
    private let api: ApiService
    
    init(api: ApiService) {
        self.api = api
    }
    
    func reserveProduct(productId id: Int, completion: @escaping (Result<Reservation>) -> Void) {
        let request = ProductReservationApiRequest(productId: id)
        
        api.execute(request: request) { (result: Result<ApiResponse<ApiReservationResponse>>) in
            switch result {
            case .success(let reservation):
                let reservationResponse = reservation.entity!.reservation
                completion(.success(reservationResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
