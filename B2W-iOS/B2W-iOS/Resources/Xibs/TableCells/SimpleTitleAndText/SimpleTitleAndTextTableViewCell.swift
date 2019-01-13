//
//  SimpleTitleAndTextTableViewCell.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class SimpleTitleAndTextTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    final fileprivate func setup() {
        isAccessibilityElement = true
    }
    
    final fileprivate func clean() {
        title.text = nil
        textDescription.text = nil
    }
}

//MARK: Public methods
extension SimpleTitleAndTextTableViewCell {
    public func contructWith(title: String?, textDescription: String?) {
        self.title.text = title
        self.textDescription.html = textDescription
    }
}
