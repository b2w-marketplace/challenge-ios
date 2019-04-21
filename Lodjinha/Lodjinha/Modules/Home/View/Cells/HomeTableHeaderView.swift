//
//  HomeTableHeaderView.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UITableViewHeaderFooterView, NibReusable {

    @IBOutlet private weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAccessibilityIdentifiers()
        applyStyle()
    }
    
    private func setupAccessibilityIdentifiers() {
        labelTitle.accessibilityIdentifier = "labelcategory"
    }
    
    private func applyStyle() {
        Style.text(font: UIFont.boldSystemFont(ofSize: 15),
                   color: .black,
                   alignment: .left)
            .apply(on: labelTitle)
    }
    
    func setup(title: String) {
        labelTitle.text = title
    }

}
