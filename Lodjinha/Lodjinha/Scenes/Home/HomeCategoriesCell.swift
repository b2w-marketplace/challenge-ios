//
//  HomeCategoriesCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 23/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct HomeCategoriesCellViewModel {
  let displayedCategories: [Home.FetchCategories.DisplayedCategory]
}

protocol HomeCategoriesCellLogic: class {
  var collectionView: UICollectionView { get }
  var delegate: HomeCategoriesCellDelegate? { get set }
  func update(viewModel: HomeCategoriesCellViewModel)
}

protocol HomeCategoriesCellDelegate: class {
  func didTapCategory(at index: Int)
}

final class HomeCategoriesCell: UITableViewCell {
  public private(set) lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseIdentifier)
    return collectionView
  }()

  var displayedCategories: [Home.FetchCategories.DisplayedCategory] = []

  weak var delegate: HomeCategoriesCellDelegate?

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
    addSubview(collectionView)
  }

  private func addConstraints() {
    constrain(self, collectionView) { cell, collectionView in
      collectionView.edges == cell.edges
    }
  }
}

// MARK: - HomeCategoriesCellLogic
extension HomeCategoriesCell: HomeCategoriesCellLogic {
  func update(viewModel: HomeCategoriesCellViewModel) {
    displayedCategories = viewModel.displayedCategories
    collectionView.reloadData()
  }
}

// MARK: - UICollectionView DataSource
extension HomeCategoriesCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return displayedCategories.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseIdentifier, for: indexPath)
    if let categoryCell = cell as? HomeCategoryCellLogic {
      let displayedCategory = displayedCategories[indexPath.item]
      let viewModel = HomeCategoryCellViewModel(displayedCategory: displayedCategory)
      categoryCell.update(viewModel: viewModel)
    }
    return cell
  }
}

// MARK: - UICollectionView Delegate
extension HomeCategoriesCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 140)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didTapCategory(at: indexPath.item)
  }
}
