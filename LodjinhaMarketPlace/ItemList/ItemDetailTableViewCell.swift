//
//  ItemDetailTableViewCell.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import UIKit

class ItemDetailTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var itemDescriptionLabel: UILabel!
    @IBOutlet private weak var itemOldPriceLabel: UILabel!
    @IBOutlet private weak var itemNewPrice: UILabel!
    @IBOutlet private weak var itemImage: UIImageView!
    
    private let numberFormatter = { () -> NumberFormatter in
        let a = NumberFormatter()
        a.formatterBehavior = NumberFormatter.Behavior.behavior10_4
        a.usesGroupingSeparator = true
        a.groupingSeparator = Locale(identifier: "pt_BR").groupingSeparator
        a.locale = Locale(identifier: "pt_BR")
        return a
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setItemDescription(_ text: String?) {
        
        itemDescriptionLabel.text = text ?? ""
    }

    func setItemOldPrice(_ value: Double?) {
        itemOldPriceLabel.attributedText = NSAttributedString(string: "De: \(format(value, with: .currency))", attributes: [.font: UIFont.systemFont(ofSize: 14.0), .foregroundColor: UIColor.lightGray, NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func setItemNewPrice(_ value: Double?) {
        itemNewPrice.attributedText = NSAttributedString(string: "Por: \(format(value, with: .currency))", attributes: [.font: UIFont.systemFont(ofSize: 18.0), .foregroundColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)])
    }

    func setItemImage(_ url: String?) {
        
        let address = URL(string: url!)
        let data = try? Data(contentsOf: address!)
        
        if let imageData = data {
            itemImage.image = UIImage(data: imageData)
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
}
