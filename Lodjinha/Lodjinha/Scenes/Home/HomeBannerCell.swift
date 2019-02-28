//
//  HomeBannerCell.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

struct HomeBannerCellViewModel {
  let displayedBanners: [Home.FetchBanner.DisplayedBanner]
}

protocol HomeBannerCellLogic: class {
  var delegate: HomeBannerCellDelegate? { get set }

  func update(viewModel: HomeBannerCellViewModel)
}

protocol HomeBannerCellDelegate: class {
  func didTap(at page: Int)
}

final class HomeBannerCell: UITableViewCell {
  private lazy var bannerView: BannerView = {
    let bannerView = BannerView()
    bannerView.layer.masksToBounds = false
    bannerView.layer.shadowOffset = CGSize(width: -1, height: 2)
    bannerView.layer.shadowRadius = 5
    bannerView.layer.shadowOpacity = 0.3
    bannerView.delegate = self
    return bannerView
  }()

  weak var delegate: HomeBannerCellDelegate?

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
    addSubview(bannerView)
  }

  private func addConstraints() {
    constrain(self, bannerView) { cell, bannerView in
      bannerView.edges == cell.edges
    }
  }
}

// MARK: - HomeBannerCellLogic
extension HomeBannerCell: HomeBannerCellLogic {
  func update(viewModel: HomeBannerCellViewModel) {
    let imageUrls = viewModel.displayedBanners.compactMap { $0.stringUrl }
    bannerView.setImageUrls(imageUrls)
  }
}

// MARK: - BannerView Delegate
extension HomeBannerCell: BannerViewDelegate {
  func didTap(at page: Int) {
    delegate?.didTap(at: page)
  }
}
