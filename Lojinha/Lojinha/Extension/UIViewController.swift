//
//  UIViewController.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

extension UIViewController
{
    func configTitle(title: String)
    {
        self.title = title
    }
    
    func setTitleWithCustomFont(title: String)
    {
        let attributes = [NSAttributedStringKey.font: UIFont(name: "Pacifico-Regular", size: 17)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        self.navigationItem.title = title
    }
}
