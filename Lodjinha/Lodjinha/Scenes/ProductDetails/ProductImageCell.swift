//
//  ProductImageCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 25/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct ProductImageCellViewModel {
  let displayedProduct: DisplayedProduct
}

protocol ProductImageCellLogic: class {
  func update(viewModel: ProductImageCellViewModel)
}

final class ProductImageCell: UITableViewCell {
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
    contentView.addSubview(productImageView)
    contentView.addSubview(nameLabel)
  }

  private func addConstraints() {
    constrain(contentView, productImageView, nameLabel) { contentView, imageView, nameLabel in
      imageView.top == contentView.top + 30
      imageView.left == contentView.left + 20
      imageView.right == contentView.right - 20
      imageView.height == 120

      nameLabel.top == imageView.bottom + 20
      nameLabel.left == contentView.left + 20
      nameLabel.bottom == contentView.bottom - 12
      nameLabel.right == contentView.right - 20
    }
  }
}

// MARK: - ProductImageCellLogic
extension ProductImageCell: ProductImageCellLogic {
  func update(viewModel: ProductImageCellViewModel) {
    productImageView.imageUrl = viewModel.displayedProduct.imageUrl
    nameLabel.text = viewModel.displayedProduct.name
  }
}
