//
//  UIViewControllerExtension.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

extension UIViewController {
    typealias SimpleAlertAction = ()-> Void
    
    func showSimpleAlertWith(title: String?,
                             description: String?,
                             confirmButtonTitle: String = "Ok",
                             cancelButtonTitle: String? = nil,
                             confirmAction: SimpleAlertAction?) {
        
        let alertController: UIAlertController = UIAlertController(title: title,
                                                                   message:description,
                                                                   preferredStyle: .alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: confirmButtonTitle,
                                                    style: .default) { (action) in
                                                        confirmAction?()
        }
        okAction.accessibilityLabel = "Alert.Ok"
        
        if let cancelTitle = cancelButtonTitle {
            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle,
                                                            style: .cancel,
                                                            handler: nil)
            cancelAction.accessibilityLabel = "Alert.Cancel"
            alertController.addAction(cancelAction)
        }
        
        alertController.addAction(okAction)
        
        let subview: UIView = alertController.view.subviews.first!
        let alertContentView: UIView = subview.subviews.first!
        
        alertContentView.tintColor = UIColor(red: 86/255, green: 41/255, blue: 126/255, alpha: 1.0)
        alertContentView.backgroundColor = UIColor.white
        alertContentView.layer.borderColor = UIColor(red: 86/255, green: 41/255, blue: 126/255, alpha: 1.0).cgColor
        alertContentView.layer.borderWidth = 0.5
        alertContentView.layer.cornerRadius = 8.0
        alertContentView.clipsToBounds = true
        
        present(alertController, animated: true, completion: nil)
    }
}
