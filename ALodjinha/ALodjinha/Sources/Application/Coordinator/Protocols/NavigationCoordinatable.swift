//
//  NavigationCoordinatable.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

protocol NavigationCoordinatable: class {
    var navigationController: UINavigationController { get }
    var rootViewController: UIViewController { get }
}
