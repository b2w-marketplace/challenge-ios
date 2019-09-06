//
//  AlodjinhaTableView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class AlodjinhaTableView: UITableView, InfinitLoadable {
    
    var infinitLoadingFooterView: InfinitLoadingFooterView
    
    override init(frame: CGRect, style: UITableView.Style) {
        infinitLoadingFooterView = InfinitLoadingFooterView()
        super.init(frame: frame, style: style)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        infinitLoadingFooterView = InfinitLoadingFooterView()
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    private func isLoading() -> Bool {
        return infinitLoadingFooterView.activityIndicator.isAnimating
    }
    
    func startInfinitLoading() {
        showFooterView(show: true)
        infinitLoadingFooterView.activityIndicator.startAnimating()
    }
    
    func stopInfinitLoading() {
        if isLoading() {
            showFooterView(show: false)
            infinitLoadingFooterView.activityIndicator.stopAnimating()
        }
    }
}
