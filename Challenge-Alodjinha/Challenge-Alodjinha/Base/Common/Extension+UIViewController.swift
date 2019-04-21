//
//  Extension+UIAlertController.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withTitle title: String, message: String) {
        let attributedText = NSMutableAttributedString(string: message, attributes: [NSAttributedString.Key.font: UIFont(name:".SFUIText-BoldItalic", size: 14)!])
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.setValue(attributedText, forKey: "attributedMessage")
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
