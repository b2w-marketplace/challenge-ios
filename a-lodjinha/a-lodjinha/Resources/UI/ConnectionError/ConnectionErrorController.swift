//
//  ConnectionErrorController.swift
//
//  Created by Daniel Rocha on 3/30/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

/**
 An encapsulation for Connection Error methods.
 */
class ConnectionErrorController {
    
    
    // MARK: Static variable
    
    static let shared: ConnectionErrorController = ConnectionErrorController()
    
    
    // MARK: Internal variables
    
    private let conectionErrorView: ConnectionErrorView
    
    // MARK: Initializers
    
    private init() {
        self.conectionErrorView = UINib(nibName: "ConnectionErrorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ConnectionErrorView
    }
    
    // MARK: External methods
    
    /**
     It shows the connection error view
     */
    
    func showConnectionError(target: Any?, action: Selector) {
        
        self.conectionErrorView.frame = UIScreen.main.bounds
    
        self.conectionErrorView.buttonOffline.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        
        
        UIApplication.shared.getWindow()?.addSubview(self.conectionErrorView)
    }
    
    /**
     It removes the connection error view
     */
    @objc func dismissConnectionError() {
        self.conectionErrorView.removeFromSuperview()
    }
}
