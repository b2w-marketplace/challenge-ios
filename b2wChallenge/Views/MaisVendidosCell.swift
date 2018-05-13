//
//  MaisVendidosCell.swift
//  b2wChallenge
//
//  Created by Felipe Mac on 10/5/18.
//  Copyright © 2018 Felipe Mac. All rights reserved.
//

import UIKit

class MaisVendidosCell: UITableViewCell {

    @IBOutlet weak var descriptionMaisVendidos: UILabel!
    @IBOutlet weak var valueMaisVendidos: UILabel!
    @IBOutlet weak var oldValueMaisVendidos: UILabel!
    @IBOutlet weak var photoMaisVendidos: UIImageView!
    
    var maisVendidos: DataMaisVendidos? {
        didSet {
            
            if let data = maisVendidos {
                
                let formatter = NumberFormatter()
                formatter.locale = Locale.current
                formatter.numberStyle = .currency
                
                descriptionMaisVendidos.text = data.nome
                
                if let valueToString = data.precoPor {
                    if let formattedTipAmount = formatter.string(from: valueToString as NSNumber) {
                        oldValueMaisVendidos.text = "De \(formattedTipAmount)"
                    }
                    
                    let attributeString =  NSMutableAttributedString(string: "\(oldValueMaisVendidos.text ?? "De")")
                    
                    attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                                 value: NSUnderlineStyle.styleSingle.rawValue,
                                                 range: NSMakeRange(0, attributeString.length))
                    self.oldValueMaisVendidos.attributedText = attributeString
                }
                
                if let valueToString = data.precoDe {
                    if let formattedTipAmount = formatter.string(from: valueToString as NSNumber) {
                        valueMaisVendidos.text = "Por \(formattedTipAmount)"
                    }
                }
                
                if let urlImage = data.urlImagem {
                    self.photoMaisVendidos.image = nil
                    
                    if let imageFromCache = Utils.imageCache.object(forKey: urlImage as AnyObject) as? UIImage {
                        self.photoMaisVendidos.image = imageFromCache
                    } else {
                        photoMaisVendidos.image = #imageLiteral(resourceName: "empty")
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
