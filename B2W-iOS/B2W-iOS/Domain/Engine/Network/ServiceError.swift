//
//  ServiceError.swift
//  
//
//  Created by Renato de Souza Machado Filho on 22/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation

func ==(lhs: ServiceError, rhs: ServiceError) -> Bool {
    switch (lhs.type, rhs.type) {
    case (.noInternet,   .noInternet),
         (.serviceUnavailable, .serviceUnavailable),
         (.serverError, .serverError),
         (.parserError, .parserError),
         (.unitTest, .unitTest),
         (.unknown, .unknown),
         (.custom, .custom),
         (.none, .none):
        return true
    default:
        return false
    }
}

class ServiceError: NSError {

    enum ErrorType {
        case custom(String)
        case noInternet
        case serviceUnavailable
        case serverError
        case parserError
        case unitTest
        case unknown
        case none
    }
    
    var type: ErrorType = .none
    
    init(type: ErrorType) {
        super.init(domain: "", code: 0, userInfo: nil)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var localizedDescription: String {
        switch self.type {
        case .custom(let msg):
            return msg
        case .noInternet:
            return "Sem conexão com a internet."
        case .serviceUnavailable:
            return "Serviço não disponível."
        case .serverError:
            return "Erro no servidor."
        case .parserError:
            return "Erro ao parsear o retorno da API."
        case .unitTest:
            return "Erro teste unitario."
        case .unknown:
            return "Erro desconhecido."
        case .none:
            return ""
        }
    }
}
