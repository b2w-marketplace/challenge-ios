//
//  NetworkError.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

enum NetworkError: Error {
    case mapping
    case weakConnection
    case offline
    case other(Error?)
    
    var localizedDescription: String {
        switch self {
        case .mapping:
            return R.string.networkError.mapping()
        case .offline:
            return R.string.networkError.offline()
        default:
            return R.string.networkError.other()
        }
    }
    
    var rawValue: Int {
        switch self {
        case .mapping:
            return 1
        case .offline:
            return 2
        default:
            return 3
        }
    }
}
