//
//  MVVMInterface.swift
//
//
//  Created by Renato Machado Filho on 27/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import Foundation

internal protocol MVVMInterface {
    associatedtype ViewModel: ViewModelInterface
    var vm: ViewModel {get}
    init()
}
