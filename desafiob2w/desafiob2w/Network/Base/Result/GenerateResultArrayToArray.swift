//
//  GenerateResultArrayToArray.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

class GenerateResultArrayToArray<CodableEntity: Codable, Entity> {
    
    private let structGenerator: ([CodableEntity]) -> [Entity]
    
    init(_ structGenerator: @escaping ([CodableEntity]) -> [Entity]) {
        self.structGenerator = structGenerator
    }
    
    func generate(_ data: Data?, _ error: NetworkError?) -> Result<[Entity], NetworkError> {
        if let data = data {
            do {
                let listCodable = try JSONDecoder().decode([CodableEntity].self, from: data)
                let list = self.structGenerator(listCodable)
                return Result.success(list)
            } catch {
                return Result.fail(.mapping)
            }
        } else if let error = error {
            return Result.fail(error)
        } else {
            return Result.fail(NetworkError.other(nil))
        }
    }
    
}
