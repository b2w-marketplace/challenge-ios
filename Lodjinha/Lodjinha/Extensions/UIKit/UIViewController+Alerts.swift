//
//  UIViewController+Alerts.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(title: String? = nil,
                      message: String,
                      actionTitle: String? = nil,
                      actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title ?? String(identifier: .titleAlert),
                                                message: message.localized,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle ?? String(identifier: .buttonOk),
                                                style: .default,
                                                handler: actionHandler))
        present(alertController, animated: true, completion: nil)
    }
    
}
