//
//  AboutView.swift
//  Lodjinha
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

protocol AboutViewLogic: class {
  var nameLabel: UILabel { get }
  var dateLabel: UILabel { get }
}

final class AboutView: UIView {
  private let logoImageView: UIImageView = {
    let image = UIImage.About.logo
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let logoTextImageView: UIImageView = {
    let image = UIImage.About.logoText
    let imageView = UIImageView(image: image)
    imageView.tintColor = .dark
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  public private(set) var nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .center
    return label
  }()

  public private(set) var dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textAlignment = .center
    return label
  }()

  init() {
    super.init(frame: .zero)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    addSubviews()
    addConstraints()

    backgroundColor = .white
  }

  private func addSubviews() {
    addSubview(logoImageView)
    addSubview(logoTextImageView)
    addSubview(nameLabel)
    addSubview(dateLabel)
  }

  private func addConstraints() {
    constrain(self, logoImageView, logoTextImageView, nameLabel, dateLabel) { view, logo, logoText, name, date in
      align(centerX: [logo, logoText, name, date])

      logo.left == view.left + 40
      logo.bottom == logoText.top - 20
      logo.right == view.right - 40

      logoText.left == view.left + 40
      logoText.right == view.right - 40
      logoText.centerY == view.centerY

      name.bottom == date.top - 8
      if #available(iOS 11.0, *) {
        date.bottom == view.safeAreaLayoutGuide.bottom - 8
      } else {
        date.bottom == view.bottom - 8
      }
    }
  }
}

extension AboutView: AboutViewLogic {
}
