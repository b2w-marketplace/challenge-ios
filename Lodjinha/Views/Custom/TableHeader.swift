//
//  TableHeader.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit

class TableHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var labelHeaderTitle: UILabel!
    
    class func headerNib() -> UINib {
        return UINib.init(nibName: "TableHeader", bundle: Bundle.main)
    }
    
    class func loadFromNib() -> TableHeader? {
        return headerNib().instantiate(withOwner: nil, options: nil).first as? TableHeader
    }
    
    func setupWithTitle(_ title: String) {
        labelHeaderTitle.text = title
    }
    
}
