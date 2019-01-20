//
//  UIView+Extensions.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        guard let nib = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as? T else { return T() }
        return nib
    }

}

class UIViewBorder: UIView {
    override func awakeFromNib() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
