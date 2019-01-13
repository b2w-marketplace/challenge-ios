//
//  GenericListModel<T: ModelInterface>.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 26/09/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation

public class GenericListModel<T: ModelInterface>: ModelInterface {
    public var objects: [T]?
    public var offset: Int?
    public var total: Int?
    public var hasNextPage: Bool = true
    
    public required init() { }
    
    public init(objects: [T]?, offset: Int?, total: Int?) {
        self.objects = objects
        self.offset = offset
        self.total = total
    }
}
