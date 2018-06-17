//
//  TabBarView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

final class TabBarView: UIView, PresentationView {
    
    var loadingView: LoadingView!
    var errorView: ErrorView!
    
    init(parentView: UIView) {
        super.init(frame: .zero)
        setupView(parentView: parentView)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
}

extension TabBarView: ViewConfiguration {
    func buildViewHierarchy() {
    }
    func setupConstraints() {
    }
}
