//
//  LoadingViewFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

struct LoadingViewFactory {
    static func make(parentView: UIView) -> LoadingView {
        return LoadingView(parentView: parentView)
    }
}
