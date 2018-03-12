//
//  TopSelledProductTableViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 10/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit
import AlamofireImage

class TopSelledProductTableViewCell: UITableViewCell, Identifiable {

    // MARK: - Properties
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    
    // MARK: - General Methods
    public func initWithModel(_ model : Product) {
        productNameLabel.text = model.name
        
        let attributedString = NSMutableAttributedString(string: "De: " + String(format: "%.2f", arguments: [model.oldPrice]))
        attributedString.addAttribute(NSAttributedStringKey.baselineOffset, value: 0, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.styleThick.rawValue), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
        oldPriceLabel.attributedText = attributedString
        
        newPriceLabel.text = "Por " + String(format: "%.2f", arguments: [model.newPrice])
        
        loadProductImage(model.imageUrl)
    }
    
    private func loadProductImage(_ imagePath : String) {
        guard let url = URL(string: imagePath) else {
            print("Error on getting url!")
            return
        }
        
        productImageView.af_setImage(withURL: url, progressQueue: .global(), imageTransition: .flipFromLeft(0.5), runImageTransitionIfCached: false)
    }
    
    // MARK: - Cell Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.text = ""
        oldPriceLabel.attributedText = NSAttributedString()
        newPriceLabel.text = ""
        productImageView.af_cancelImageRequest()
    }

}
