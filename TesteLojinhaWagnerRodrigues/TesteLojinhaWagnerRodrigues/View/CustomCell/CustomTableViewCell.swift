//
//  CustomTableViewCell.swift
//  TesteLojinhaWagnerRodrigues
//
//  Created by Wagner Rodrigues on 10/06/2018.
//  Copyright © 2018 Wagner Rodrigues. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelPriceBefore: UILabel!
    @IBOutlet weak var labelPriceNow: UILabel!
    
    @IBOutlet weak var buttonSelectItem: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
