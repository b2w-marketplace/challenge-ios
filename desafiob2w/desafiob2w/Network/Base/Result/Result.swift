//
//  Result.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

enum Result<T, E> where E: Error {
    case success(T)
    case fail(E)
}
