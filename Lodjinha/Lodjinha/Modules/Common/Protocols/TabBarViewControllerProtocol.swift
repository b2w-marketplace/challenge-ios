//
//  TabBarViewControllerProtocol.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarViewControllerProtocol {
    
    var tabNormalIcon: UIImage { get }
    var tabSelectedIcon: UIImage { get }
    var tabTitle: String { get }
    
    func configuredViewController() -> UIViewController
    
}
