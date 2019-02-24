//
//  ProductCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 24/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct ProductCellViewModel {
  let displayedProduct: Home.FetchBestsellers.DisplayedProduct
}

protocol ProductCellLogic: class {
  func update(viewModel: ProductCellViewModel)
}

final class ProductCell: UITableViewCell {
  private let productImageView: URLImageView = {
    let imageView = URLImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFont(ofSize: 16)
    return label
  }()

  private let fromLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    return label
  }()

  private let toLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textColor = .red
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

    accessoryType = .disclosureIndicator
  }

  private func addSubviews() {
    contentView.addSubview(productImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(fromLabel)
    contentView.addSubview(toLabel)
  }

  private func addConstraints() {
    constrain(
      contentView,
      productImageView,
      nameLabel,
      fromLabel,
      toLabel) { contentView, imageView, nameLabel, fromLabel, toLabel in
        imageView.top == contentView.top + 20
        imageView.left == contentView.left + 8
        imageView.bottom == contentView.bottom - 20 ~ .defaultHigh
        imageView.width == 80
        imageView.height == 80

        nameLabel.top == contentView.top + 20
        nameLabel.left == imageView.right + 8
        nameLabel.right == contentView.right - 8

        fromLabel.top >= nameLabel.bottom + 8
        fromLabel.left == nameLabel.left
        fromLabel.bottom == contentView.bottom - 20

        toLabel.top == fromLabel.top
        toLabel.left == fromLabel.right + 8
        toLabel.bottom == fromLabel.bottom
        toLabel.right == contentView.right - 8
    }
  }
}

// MARK: - HomeBannerCellLogic
extension ProductCell: ProductCellLogic {
  func update(viewModel: ProductCellViewModel) {
    productImageView.imageUrl = viewModel.displayedProduct.imageUrl
    nameLabel.text = viewModel.displayedProduct.name
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
