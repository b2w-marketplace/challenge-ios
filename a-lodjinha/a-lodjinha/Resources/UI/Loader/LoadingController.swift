//
//  LoadingController.swift
//  TopGamesPAN
//
//  Created by Daniel Rocha on 3/30/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

/**
 A default class for loading views
 */
class LoadingViewController {
    
    
    // MARK: Static variable
    
    static let shared: LoadingViewController = LoadingViewController()
    
    
    // MARK: Internal variables
    
    private let loadingView: LoadingView
    
    
    // MARK: Initializers
    
    private init() {
        self.loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingView
    }
    
    
    // MARK: External methods
    
    /**
     It shows the loading view
     */
    func show(withAnimation:Bool = true, viewContainer: UIView? = nil) {
        if let viewContainer = viewContainer {
            self.loadingView.frame = CGRect(x: 0, y:0, width:viewContainer.frame.size.width, height: viewContainer.frame.size.height)
            viewContainer.addSubview(self.loadingView)
            viewContainer.bringSubview(toFront: self.loadingView)
        } else {           
            
            self.loadingView.frame = UIScreen.main.bounds
            UIApplication.shared.getWindow()?.addSubview(self.loadingView)
        }
        
        if withAnimation {
            self.loadingView.startAnimation()
        }
    }
    
    /**
     It removes the loading view
     */
    func dismiss() {
        self.loadingView.removeFromSuperview()
    }
}
