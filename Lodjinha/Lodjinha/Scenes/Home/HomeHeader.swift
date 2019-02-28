//
//  HomeHeader.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct HomeHeaderViewModel {
  let title: String
}

protocol HomeHeaderLogic: class {
  func update(viewModel: HomeHeaderViewModel)
}

final class HomeHeader: UITableViewHeaderFooterView {
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()

  private let line: UIView = {
    let line = UIView()
    line.backgroundColor = .lightGray
    return line
  }()

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    addSubviews()
    addConstraints()

    backgroundColor = .clear
  }

  private func addSubviews() {
    addSubview(titleLabel)
    addSubview(line)
  }

  private func addConstraints() {
    constrain(self, titleLabel, line) { cell, title, line in
      title.left == cell.left + 20

      line.top == title.bottom + 8
      line.left == cell.left
      line.bottom == cell.bottom
      line.right == cell.right
      line.height == 0.5
    }
  }
}

// MARK: - HomeHeaderLogic
extension HomeHeader: HomeHeaderLogic {
  func update(viewModel: HomeHeaderViewModel) {
    titleLabel.text = viewModel.title
  }
}
