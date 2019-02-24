//
//  DataContainer.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

struct DataContainer<T>: Decodable where T: Decodable {
  let data: T
}
