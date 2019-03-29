//
//  ApiReservationResponse.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import Foundation

struct ApiReservationResponse: Decodable {

    let result: String
    let mensagem: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case mensagem
    }
    
    var reservation: Reservation {
        return Reservation(result: result, message: mensagem)
    }
}
