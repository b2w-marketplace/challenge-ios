//
//  InfinitLoadingFooterView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class InfinitLoadingFooterView: UIView, NibDesignable {
    
    @IBOutlet var view: UIView! {
        didSet {
            view.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .whiteLarge
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
}
