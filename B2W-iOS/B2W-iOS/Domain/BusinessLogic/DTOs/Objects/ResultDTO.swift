//
//  ResultDTO.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

struct ResultDTO: DTOInterface {
    typealias Model = ResultModel
    
    var result: String?
    
    init(model: ResultModel?) {
        result = model?.result
    }
    
    func parseToModel() -> ResultModel {
        let model: Model = Model(result: result)
        return model
    }
}
