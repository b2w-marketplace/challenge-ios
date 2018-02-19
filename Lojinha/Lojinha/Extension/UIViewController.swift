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
    func set(title: String)
    {
        self.title = title
    }
    
    func setTitleWithCustomFont(title: String)
    {
        let attributes = [NSAttributedStringKey.font: UIFont(name: "Pacifico-Regular", size: 24)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        self.navigationItem.title = title
    }
    
    func setImageInTitle()
    {
        let img = UIImage(named: "ic_logo_navbar")
        let imgView = UIImageView(image: img)
        self.navigationItem.titleView = imgView
    }    
}
