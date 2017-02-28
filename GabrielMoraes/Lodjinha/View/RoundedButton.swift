//
//  RoundedButton.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.indicator.center = self.center
        self.superview?.insertSubview(self.indicator, aboveSubview: self)
    }
    
    func startLoading() {
        self.isEnabled = false
        self.indicator.startAnimating()
        self.setTitle("", for: .disabled)
        self.setImage(UIImage(), for: .disabled)
    }
    
    func stopLoading() {
        self.setTitle(self.currentTitle, for: .disabled)
        self.setImage(self.currentImage, for: .disabled)
        self.isEnabled = true
        self.indicator.stopAnimating()
    }

}
