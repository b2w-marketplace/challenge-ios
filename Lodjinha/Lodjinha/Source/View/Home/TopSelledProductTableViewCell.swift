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
        oldPriceLabel.text = "De: " + String(describing: model.oldPrice)
        newPriceLabel.text = "Por: " + String(describing: model.newPrice)
        loadProductImage(model.imageUrl)
    }
    
    private func loadProductImage(_ imagePath : String) {
        guard let url = URL(string: imagePath) else {
            print("Error on getting url!")
            return
        }
        
        productImageView.af_setImage(withURL: url, progressQueue: .global(), imageTransition: .flipFromLeft(0.5), runImageTransitionIfCached: true)
    }
    
    // MARK: - Cell Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        productNameLabel.text = ""
        oldPriceLabel.text = ""
        newPriceLabel.text = ""
        productImageView.af_cancelImageRequest()
    }

}
