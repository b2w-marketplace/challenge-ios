//
//  UINavigationController+BackButtonTitle.swift
//  Lodjinha
//
//  Created by Marcos on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func addBackButton(title: String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
