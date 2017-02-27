//
//  Extensions.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = Constants.colorDarkishPurple
        self.tabBarController?.tabBar.tintColor = Constants.colorWarmPurple
    }
    
}

extension Float {
    
    var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self))!
    }
    
}
