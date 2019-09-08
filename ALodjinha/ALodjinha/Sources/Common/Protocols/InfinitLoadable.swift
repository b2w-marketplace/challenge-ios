//
//  InfinitLoadable.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

protocol InfinitLoadable {
    var infinitLoadingFooterView: InfinitLoadingFooterView { get }
    func setupLayout()
    func showFooterView(show: Bool)
}

extension InfinitLoadable where Self: UITableView {
    func setupLayout() {
        infinitLoadingFooterView.frame = CGRect(x: 0.0,
                                                y: 0.0,
                                                width: self.frame.size.width,
                                                height: 0.0)
        self.tableFooterView = infinitLoadingFooterView
    }
    
    func showFooterView(show: Bool) {
        let height: CGFloat = show ? 44.0 : 0.0
        infinitLoadingFooterView.frame = CGRect(x: 0.0,
                                                y: 0.0,
                                                width: self.frame.size.width,
                                                height: height)
        self.tableFooterView = infinitLoadingFooterView
        
        if show {
            let bottomOffset = CGPoint(x: 0.0,
                                       y: self.contentSize.height - self.bounds.size.height)
            self.setContentOffset(bottomOffset, animated: true)
        }
    }
}
