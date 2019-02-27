//
//  HomeCategoryCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct HomeCategoryCellViewModel {
  let displayedCategory: Home.FetchCategories.DisplayedCategory
}

protocol HomeCategoryCellLogic: class {
  func update(viewModel: HomeCategoryCellViewModel)
}

final class HomeCategoryCell: UICollectionViewCell {
  private let categoryImageView: URLImageView = {
    let imageView = URLImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .center
    label.setContentCompressionResistancePriority(.required, for: .vertical)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
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
    addSubview(categoryImageView)
    addSubview(descriptionLabel)
  }

  private func addConstraints() {
    constrain(self, categoryImageView, descriptionLabel) { cell, imageView, label in
      imageView.top == cell.top + 20
      imageView.left == cell.left + 8
      imageView.right == cell.right - 8

      label.top == imageView.bottom + 8
      label.left == cell.left
      label.bottom == cell.bottom - 20
      label.right == cell.right
    }
  }
}

// MARK: - HomeCategoryCellLogic
extension HomeCategoryCell: HomeCategoryCellLogic {
  func update(viewModel: HomeCategoryCellViewModel) {
    categoryImageView.imageUrl = viewModel.displayedCategory.imageUrl
    descriptionLabel.text = viewModel.displayedCategory.description
  }
}
