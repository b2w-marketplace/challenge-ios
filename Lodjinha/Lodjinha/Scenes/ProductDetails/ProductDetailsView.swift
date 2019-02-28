//
//  ProductDetailsView.swift
//  Lodjinha
//
//  Created by Gilson Gil on 25/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

protocol ProductDetailsViewLogic: class {
  var tableView: UITableView { get }
  var button: UIButton { get }
}

protocol ProductDetailsViewDelegate: class {
  func didTapReserve()
}

final class ProductDetailsView: UIView {
  public private(set) lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
    return tableView
  }()

  private let buttonContainer: UIView = {
    let view = UIView()
    let border = CAShapeLayer()
    let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5)
    border.path = UIBezierPath(rect: rect).cgPath
    border.strokeColor = UIColor(white: 0.9, alpha: 1).cgColor
    view.layer.addSublayer(border)
    return view
  }()

  public private(set) lazy var button: UIButton = {
    let button = UIButton()
    button.backgroundColor = .purple
    button.setTitle(String.ProductDetails.reserveButton, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(reserveTapped), for: .touchUpInside)
    return button
  }()

  private weak var delegate: ProductDetailsViewDelegate?

  init(delegate: ProductDetailsViewDelegate) {
    self.delegate = delegate
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
    addSubview(buttonContainer)
    buttonContainer.addSubview(button)
  }

  private func addConstraints() {
    constrain(self, tableView, buttonContainer) { view, tableView, buttonContainer in
      tableView.top == view.top
      tableView.left == view.left
      tableView.right == view.right

      buttonContainer.top == tableView.bottom
      buttonContainer.left == view.left
      buttonContainer.bottom == view.bottom
      buttonContainer.right == view.right
    }

    constrain(buttonContainer, button) { buttonContainer, button in
      button.top == buttonContainer.top + 8
      button.left == buttonContainer.left + 10
      if #available(iOS 11.0, *) {
        button.bottom == buttonContainer.safeAreaLayoutGuide.bottom - 8
      } else {
        button.bottom == buttonContainer.bottom - 8
      }
      button.right == buttonContainer.right - 10
      button.height == 60
    }
  }
}

// MARK: - Actions
@objc
extension ProductDetailsView {
  func reserveTapped() {
    button.startLoading()
    delegate?.didTapReserve()
  }
}

extension ProductDetailsView: ProductDetailsViewLogic {
}
