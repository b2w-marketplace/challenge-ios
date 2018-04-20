//
//  LoadingView.swift
//  TopGamesPAN
//
//  Created by Daniel Rocha on 3/30/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

/**
 A default class for loading views
 */
class LoadingView: UIView {
    
    
    // MARK: Variables
  
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: External methods
    
    func startAnimation() {
        self.activityIndicator.startAnimating()
    }
}
