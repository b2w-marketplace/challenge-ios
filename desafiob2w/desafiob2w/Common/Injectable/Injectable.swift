//
//  Injectable.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype T
    func inject(_: T)
    func assertDependencies()
}
