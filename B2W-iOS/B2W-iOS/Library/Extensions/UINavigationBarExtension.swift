//
//  UINavigationBar+Setup.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    static func setupUI() {
        let tintColor : UIColor = .white
        let barColor  : UIColor = UIColor(red: 86/255, green: 41/255, blue: 126/255, alpha: 1.0)
        
        appearance().layer.masksToBounds = false
        appearance().isTranslucent = false
        appearance().tintColor = tintColor
        appearance().barTintColor = barColor
        appearance().titleTextAttributes = [.foregroundColor : tintColor,
                                            .font: UIFont(name: "Pacifico-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]
    }
}
