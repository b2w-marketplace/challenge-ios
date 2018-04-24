//
//  Extensions.swift
//  Lodginha
//
//  Created by Ricardo Bailoni on 22/04/2018.
//  Copyright © 2018 Ricardo Bailoni. All rights reserved.
//

import UIKit

enum AlertType: String {
    case error = "Erro"
    case warning = "Atenção"
    case success = "Sucesso"
}

let cacheImagens = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var stringURLImage: String?
    
    func loadImageWithStringURL(stringURL: String) {
        image = nil
        stringURLImage = stringURL
        guard let url = URL(string: stringURL) else {
            return
        }
        
        if let imageFromCache = cacheImagens.object(forKey: stringURL as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "errorLoadImage")
                }
                return
            }
            
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data!) {
                    if self.stringURLImage == stringURL {
                        self.image = imageToCache
                    }
                    cacheImagens.setObject(imageToCache, forKey: stringURL as NSString)
                }
            }
        }.resume()
    }
}

class CustomAlert: UIAlertController {
    class func loadAlert(type: AlertType, message: String, actions: [UIAlertAction]? = nil) -> UIAlertController {
        let alert = UIAlertController(title: type.rawValue, message: message, preferredStyle: .alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        return alert
    }
}

extension Double {
    func formatNumber(prefix: String?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = prefix ?? ""
        numberFormatter.alwaysShowsDecimalSeparator = true
        
        return numberFormatter.string(for: self) ?? "0"
    }
}

extension String {
    var html: NSAttributedString? {
        do {
            guard let data = data(using: .utf8) else {
                return nil
            }
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
