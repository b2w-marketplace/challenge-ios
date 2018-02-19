//
//  Alert.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

let popViewControllerNotificationCenter = Notification.Name(rawValue: NotificationName.popView.rawValue)

class Alert: NSObject
{
    static func show(title: String? = nil, message: String?, isSuccess: Bool? = nil) -> UIAlertController
    {
        let alert = UIAlertController(title: title ?? "Desculpe..." , message: (message), preferredStyle: UIAlertControllerStyle.alert)
        if isSuccess ?? false
        {
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (alert) in
                NotificationCenter.default.post(name: popViewControllerNotificationCenter, object: nil)
            }))
        }
        else
        {
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        }
        
        return alert
    }
}
