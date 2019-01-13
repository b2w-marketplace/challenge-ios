//
//  ServiceHeader.swift
//  
//
//  Created by Renato Machado Filho on 22/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation

internal struct ServiceHeader {
    static var header: [String: String] {
        get {
            var values: [String: String] = [:]
            values[NetworkConstants.Network.HTTPHeaderField.acceptType.rawValue] = NetworkConstants.Network.ContentType.json.rawValue
            values[NetworkConstants.Network.HTTPHeaderField.contentType.rawValue] = NetworkConstants.Network.ContentType.json.rawValue
            return values
        }
    }
}
