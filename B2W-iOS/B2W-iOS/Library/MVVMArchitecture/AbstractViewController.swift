//
//  AbstractViewController.swift
//  
//
//  Created by Renato Machado Filho on 27/08/18.
//  Copyright © 2018 Renato Machado Filho. All rights reserved.
//

import UIKit

open class AbstractViewController<T: ViewModelInterface>: UIViewController, MVVMInterface {
    typealias ViewModel = T
    
    public var vm: T
    
    required public init() {
        vm = T()
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        vm = T()
        super.init(coder: aDecoder)
    }
}
