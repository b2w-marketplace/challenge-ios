//
//  ErrorViewFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

enum ErrorViewFactory {
    static func make(parentView: UIView) -> ErrorView {
        return ErrorView(parentView: parentView)
    }
}
