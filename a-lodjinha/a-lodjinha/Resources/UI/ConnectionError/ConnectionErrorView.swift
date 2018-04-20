//
//  ConnectionErrorView.swift
//
//  Created by Daniel Rocha on 3/30/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit


/**
 A default view for Conection Errors
 */
class ConnectionErrorView: UIView {
    
    
    // MARK: Variables
    
    @IBOutlet weak var buttonOffline: CustomButton!
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
