//
//  LoadingCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 25/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

final class LoadingCell: UITableViewCell {
  private let loadingView: UIActivityIndicatorView = {
    let loading = UIActivityIndicatorView(style: .gray)
    loading.color = .purple
    loading.startAnimating()
    return loading
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
    contentView.addSubview(loadingView)
  }

  private func addConstraints() {
    constrain(contentView, loadingView) { contentView, loadingView in
      loadingView.center == contentView.center
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    loadingView.startAnimating()
  }
}
