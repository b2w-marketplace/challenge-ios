//
//  CustomNavigationController.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 16/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController , UIAlertViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
               
        let primaryColor = UIColor(red: 94/255.0, green: 42/255.0, blue: 132/255.0, alpha: 1.0)
        let itemColor = UIColor.white
        
        var dict = Dictionary<String, UIColor>()
        dict.updateValue(itemColor,
                         forKey: NSForegroundColorAttributeName)
        dict.updateValue(itemColor,
                         forKey: NSBackgroundColorAttributeName)
        self.navigationBar.titleTextAttributes = dict
        
        self.navigationBar.barTintColor = primaryColor
        self.navigationBar.tintColor = itemColor
        self.navigationBar.isTranslucent = false
        
        UIToolbar.appearance().tintColor = itemColor
        UITabBar.appearance().tintColor = primaryColor
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
