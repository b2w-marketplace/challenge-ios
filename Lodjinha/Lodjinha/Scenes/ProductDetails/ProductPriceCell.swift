//
//  ProductPriceCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 25/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct ProductPriceCellViewModel {
  let displayedProduct: DisplayedProduct
}

protocol ProductPriceCellLogic: class {
  func update(viewModel: ProductPriceCellViewModel)
}

final class ProductPriceCell: UITableViewCell {
  public private(set) var fromLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    return label
  }()

  public private(set) var toLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .red
    label.textAlignment = .right
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    addSubviews()
    addConstraints()
  }

  private func addSubviews() {
    contentView.addSubview(fromLabel)
    contentView.addSubview(toLabel)
  }

  private func addConstraints() {
    constrain(contentView, fromLabel, toLabel) { contentView, fromLabel, toLabel in
        fromLabel.top == contentView.top + 12
        fromLabel.left == contentView.left + 20
        fromLabel.bottom == contentView.bottom - 12

        toLabel.top == fromLabel.top
        toLabel.left == fromLabel.right + 8
        toLabel.bottom == fromLabel.bottom
        toLabel.right == contentView.right - 20
    }
  }
}

// MARK: - ProductPriceCellLogic
extension ProductPriceCell: ProductPriceCellLogic {
  func update(viewModel: ProductPriceCellViewModel) {
    toLabel.text = viewModel.displayedProduct.toPrice
    let fromPrice = viewModel.displayedProduct.fromPrice
    let fromAttributes: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.foregroundColor: UIColor.lightGray,
      NSAttributedString.Key.strikethroughColor: UIColor.lightGray,
      NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue
    ]
    let fromPriceAttr = NSAttributedString(string: fromPrice, attributes: fromAttributes)
    fromLabel.attributedText = fromPriceAttr
  }
}
