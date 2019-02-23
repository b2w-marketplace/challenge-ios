//
//  HomeView.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

protocol HomeViewLogic: class {
  var tableView: UITableView { get }
}

final class HomeView: UIView {
  public private(set) lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    return tableView
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
    addSubview(tableView)
  }

  private func addConstraints() {
    constrain(self, tableView) { view, tableView in
      tableView.edges == view.edges
    }
  }
}

extension HomeView: HomeViewLogic {
}
