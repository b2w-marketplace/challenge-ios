//
//  Utils.swift
//  GuihMoviesDatabase
//
//  Created by Guilherme Antunes on 27/02/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import Foundation
import UIKit

let showActivity = UIActivityIndicatorView()

func startLoading(view : UIView) {
    
    showActivity.center = CGPoint(x: view.center.x, y: view.center.y)
    showActivity.color = UIColor.purple
    view.addSubview(showActivity)
    view.bringSubview(toFront: showActivity)
    showActivity.startAnimating()
    
}

func stopLoading() {
    
    showActivity.stopAnimating()
    showActivity.removeFromSuperview()
    
}

func createGradient(frame : CGRect, forView view : UIView) {
    let gradient = CAGradientLayer()
    
    gradient.frame = frame
    gradient.locations = [0, 1]
    gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    
    view.layer.insertSublayer(gradient, at: 0)
}
