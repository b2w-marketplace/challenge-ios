//
//  ViewConfiguration.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import Foundation
protocol ViewConfiguration: class {
    func setupConstraints()
    func buildViewHierarchy()
    func setupViewConfiguration()
    func configureViews()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    func configureViews() {
        
        
    }
}
