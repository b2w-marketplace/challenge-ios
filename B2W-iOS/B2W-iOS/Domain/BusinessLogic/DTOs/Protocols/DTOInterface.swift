//
//  DTOInterface.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 17/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation

internal protocol DTOInterface: Codable {
    associatedtype Model: ModelInterface
    init(model: Model?)
    func parseToModel() -> Model
}
