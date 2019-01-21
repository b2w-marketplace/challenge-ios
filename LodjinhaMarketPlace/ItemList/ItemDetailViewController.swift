//
//  ItemDetailViewController.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemDetailViewController: UIViewController {
    
    var productDetail: Product?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionText: UITextView!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productNewPriceLabel: UILabel!
    @IBOutlet weak var productBuyButton: UIButton!
    
    private let numberFormatter = { () -> NumberFormatter in
        let a = NumberFormatter()
        a.formatterBehavior = NumberFormatter.Behavior.behavior10_4
        a.usesGroupingSeparator = true
        a.groupingSeparator = Locale(identifier: "pt_BR").groupingSeparator
        a.locale = Locale(identifier: "pt_BR")
        return a
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(presentResult(_:)), name: .ProductReservation, object: nil)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3.0
        paragraphStyle.alignment = .left
        
        self.tabBarController?.tabBar.isHidden = true
        
        productDescriptionText.text = productDetail!.descricao
        productOldPriceLabel.attributedText = NSAttributedString(string: "De: \(format(productDetail!.precoDe!, with: .currency))", attributes: [.font: UIFont.systemFont(ofSize: 14.0), .foregroundColor: UIColor.lightGray, NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        
        productNewPriceLabel.attributedText = NSAttributedString(string: "Por: \(format(productDetail!.precoPor!, with: .currency))", attributes: [.font: UIFont.systemFont(ofSize: 18.0), .foregroundColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)])
        
        productNameLabel.attributedText = NSAttributedString(string: productDetail!.nome!, attributes: [.font: UIFont.systemFont(ofSize: 16.0), .foregroundColor: UIColor.darkText, .paragraphStyle: paragraphStyle])
        
        productDescriptionText.attributedText = productDetail!.descricao!.simpleHtmlAttributedString(base: [.font: UIFont.systemFont(ofSize: 16.0, weight: .regular), .foregroundColor: UIColor.darkText, .paragraphStyle: paragraphStyle], bold: [.font: UIFont.systemFont(ofSize: 16.0), .foregroundColor: UIColor.darkText, .paragraphStyle: paragraphStyle], italic: [.font: UIFont.systemFont(ofSize: 16.0), .foregroundColor: UIColor.darkText, .paragraphStyle: paragraphStyle])
        
        let address = URL(string: (productDetail!.urlImagem!))
        let data = try? Data(contentsOf: address!)
        
        if let imageData = data {
            productImage.image = UIImage(data: imageData)
        }
        
        productBuyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        productBuyButton.titleLabel?.minimumScaleFactor = 0.5
        productBuyButton.alpha = 1.0
        productBuyButton.contentHorizontalAlignment = .center
        productBuyButton.contentVerticalAlignment = .center
        productBuyButton.titleLabel?.lineBreakMode = .byWordWrapping
        productBuyButton.setAttributedTitle(NSMutableAttributedString(string: NSLocalizedString("Reservar", comment: "").capitalized,  attributes: [.font: UIFont.systemFont(ofSize: 18.0, weight: .bold), .foregroundColor: UIColor.white, .kern: 0.0]), for: UIControl.State.normal)
        productBuyButton.backgroundColor = #colorLiteral(red: 0.3635124564, green: 0.1653201878, blue: 0.5164173245, alpha: 1)
        productBuyButton.tintColor = .white
        productBuyButton.layer.borderColor = #colorLiteral(red: 0.3635124564, green: 0.1653201878, blue: 0.5164173245, alpha: 1)
        productBuyButton.layer.borderWidth = 1
        productBuyButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Title View
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        subtitleLabel.attributedText = NSMutableAttributedString(string: (productDetail?.categoria?.descricao)!,  attributes: [.font: UIFont.systemFont(ofSize: 24.0, weight: .medium), .foregroundColor: UIColor.white, .backgroundColor: UIColor.clear, .kern: 0.0])
        subtitleLabel.sizeToFit()
        
        let titleViewFrame = CGRect(x: 0, y: 0, width: subtitleLabel.frame.size.width, height: 30)
        let titleView = UIView(frame: titleViewFrame)
        titleView.backgroundColor = UIColor.clear
        
        var adjustment = subtitleLabel.frame
        adjustment.origin.x = titleView.frame.origin.x + (titleView.frame.width/2) - (subtitleLabel.frame.width/2)
        subtitleLabel.frame = adjustment
        titleView.addSubview(subtitleLabel)
        
        navigationItem.titleView = titleView
    }

    @objc func presentResult(_ notification: NSNotification) {
        if let validCode = notification.userInfo?["resultSuccess"] as? Bool, validCode {
            let jsonResult = JSON.init(parseJSON: (notification.userInfo!["resultData"] as? String)!)
            
            if jsonResult["result"].string! == "success" {
                showAlert("Produto reservado com sucesso")
            } else {
                showAlert(jsonResult["result"].string!)
            }
        } else {
            showAlert("Erro de Serviço")
        }
        
    }
    
    private func format(_ number: Double?, with style: NumberFormatter.Style?) -> String {
        
        numberFormatter.numberStyle = style ?? .decimal
        
        guard let numberToFormat = number else {
            self.numberFormatter.numberStyle = .decimal
            return self.numberFormatter.string(from: NSNumber(value: 0.0))!
        }
        
        return self.numberFormatter.string(from: NSNumber(value: numberToFormat)) ?? ""
    }
    
    private func showAlert(_ message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func requestReservation(_ sender: Any) {
        HTTPServices.reservationProduct(productDetail!.id!)
    }
}
