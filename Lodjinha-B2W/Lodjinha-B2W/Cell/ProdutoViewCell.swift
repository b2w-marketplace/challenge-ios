//
//  ProdutoViewCell.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import UIKit

class ProdutoViewCell: UITableViewCell {

    @IBOutlet weak var produtoImage: UIImageView!
    @IBOutlet weak var nomeProdutoLabel: UILabel!
    @IBOutlet weak var deLabel: UILabel!
    @IBOutlet weak var porLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
