//
//  ResultModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

public class ResultModel: ModelInterface {
    
    public var result: String?
    
    public required init() { }
    
    public init(result: String?) {
        self.result = result
    }
}
