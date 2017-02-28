//
//  RoundedButton.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }

}
