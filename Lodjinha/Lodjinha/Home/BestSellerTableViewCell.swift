//
//  BestSellerTableViewCell.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit

class BestSellerViewModel{
    var imageURL:URL
    var title:String
    var discountPriceString:String{
        return "De: \(price)"
    }
    var discountPrice:Double
    
    var priceString:String{
        return "Por: \(price)"
    }
    var price:Double
     var model:Produto
    
    init(model:Produto) {
        self.imageURL = URL(string:model.urlImagem)!
        self.title = model.nome
        self.discountPrice = model.precoDe
        self.price = model.precoPor
        self.model = model
    }
}

class BestSellerTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageItemView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    static func register(to tableView:UITableView) {
        let nib = UINib(nibName: "BestSellerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "BestSellerTableViewCell")
    }
    
    
    func setup(viewModel:BestSellerViewModel){
        self.accessoryType = .disclosureIndicator
        self.titleLabel.text = viewModel.title
        self.discountPriceLabel.text = viewModel.discountPriceString
        self.priceLabel.text = viewModel.priceString
        
        imageItemView.kf.indicatorType = .activity
        imageItemView.kf.setImage(with: viewModel.imageURL,
                                  options: [],
                                  completionHandler: { [ weak self] image, error, cacheType, imageURL in
                                    self?.imageItemView.layer.shadowOpacity = 0.5
        })
    }
    
}
