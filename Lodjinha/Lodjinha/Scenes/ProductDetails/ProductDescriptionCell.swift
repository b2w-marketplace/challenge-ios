//
//  ProductDescriptionCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 25/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct ProductDescriptionCellViewModel {
  let displayedProduct: DisplayedProduct
}

protocol ProductDescriptionCellLogic: class {
  func update(viewModel: ProductDescriptionCellViewModel)
}

final class ProductDescriptionCell: UITableViewCell {
  public private(set) var textView: UITextView = {
    let textView = UITextView()
    textView.isEditable = false
    textView.isSelectable = false
    textView.isScrollEnabled = false
    return textView
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
    contentView.addSubview(textView)
  }

  private func addConstraints() {
    constrain(contentView, textView) { contentView, textView in
      textView.top == contentView.top + 12
      textView.left == contentView.left + 20
      textView.bottom == contentView.bottom - 20
      textView.right == contentView.right - 20
    }
  }
}

// MARK: - ProductDescriptionCellLogic
extension ProductDescriptionCell: ProductDescriptionCellLogic {
  func update(viewModel: ProductDescriptionCellViewModel) {
    let descriptionData = viewModel.displayedProduct.description.data(using: String.Encoding.unicode) ?? Data()
    let descriptionOptions: [NSAttributedString.DocumentReadingOptionKey: NSAttributedString.DocumentType]
    descriptionOptions = [.documentType: .html]
    let description = try? NSMutableAttributedString(data: descriptionData,
                                                     options: descriptionOptions,
                                                     documentAttributes: nil)
    textView.attributedText = description
  }
}
