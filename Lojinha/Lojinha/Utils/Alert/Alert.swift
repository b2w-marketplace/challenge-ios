//
//  Alert.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class Alert: NSObject
{
    static func show(message: String?) -> UIAlertController
    {
        let alert = UIAlertController(title: "Desculpe..." , message: (message), preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
