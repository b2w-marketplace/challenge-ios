//
//  NavigationTitleView.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

extension UIViewController {

    func setupNavigationView() -> UIView {
        let view = UIView()
        let image = UIImage(named: "logoSobre")
        let imageView = UIImageView(image: image)
        let title = UILabel()
        title.text = " a Lodjinha"
        title.sizeToFit()
        title.center = view.center
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.white
        title.font = UIFont(name: "Pacifico", size: 17.0)
        
        
        let imageAspect = imageView.image!.size.width/imageView.image!.size.height
        imageView.frame = CGRect(x: title.frame.origin.x-title.frame.size.height*imageAspect, y: title.frame.origin.y, width: title.frame.size.height*imageAspect, height: title.frame.size.height)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        view.addSubview(title)
        view.addSubview(imageView)
        
        return view
    }
   
}
