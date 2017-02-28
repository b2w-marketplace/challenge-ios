//
//  Extensions.swift
//  Lodjinha
//
//  Created by Gabriel Moraes on 2/27/17.
//  Copyright © 2017 Gabriel Moraes. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barStyle = .black
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = Constants.colorDarkishPurple
        self.tabBarController?.tabBar.tintColor = Constants.colorWarmPurple
    }
    
}

extension Float {
    
    var asLocaleCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self))!
    }
    
}

extension UIViewController {
    
    func showErrorAlert(with message: String?) {
        let alertController = UIAlertController(title: Strings.errorTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showInfoAlert(with message: String?) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            print(self.navigationController?.popViewController(animated: true) ?? "View controller is nil")
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIRefreshControl {
    
    func insert(in view: UIScrollView) {
        view.addSubview(self)
        view.alwaysBounceVertical = true
        self.layoutIfNeeded()
        view.contentOffset = CGPoint(x: 0, y: -self.frame.size.height)
        self.beginRefreshing()
    }
    
}

extension Data {
    
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
extension String {
    
    var utf8Data: Data? {
        return data(using: .utf8)
    }
    
}
