//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let identifier: String = "ProductTableViewCell"
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPriceBefore: UILabel!
    @IBOutlet weak var productPriceNow: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(withProduct product: Product, isLastIndex: Bool) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "pt-BR")
        productImage.setImage(fromUrl: product.imageUrl, withIndicator: nil, defaultImage: UIImage(named: "downloadImageDefault"))
        productName.text = product.name
        
        //Attributed Text
        let text = "De \(numberFormatter.string(from: NSNumber(value: product.priceBefore))!)"
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.strikethroughStyle : 1])
        productPriceBefore.attributedText = attributedString
        
        productPriceNow.text = "Por \(numberFormatter.string(from: NSNumber(value: product.priceNow))!)"
        separatorView.isHidden = isLastIndex
    }
    
}

@IBDesignable
class SwiftDisclosureIndicator: UIView {
    @IBInspectable var color = UIColor.purple {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 4
        let y = self.bounds.midY
        let R = CGFloat(2.5)
        context?.move(to: CGPoint(x: x - R*2, y: y - R*2))
        context?.addLine(to: CGPoint(x: x, y: y))
        context?.addLine(to: CGPoint(x: x - R*2, y: y + R*2))
        context?.setLineCap(.square)
        context?.setLineJoin(.miter)
        context?.setLineWidth(2)
        color.setStroke()
        context?.strokePath()
    }
}
