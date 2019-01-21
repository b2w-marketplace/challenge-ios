//
//  StoryboardIdentifiable.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 21/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
