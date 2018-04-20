//
//  CustomButton.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/20/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class CustomButton: UIButton {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.height * 0.2
        self.backgroundColor = UIColor.customButton
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
    }


}
