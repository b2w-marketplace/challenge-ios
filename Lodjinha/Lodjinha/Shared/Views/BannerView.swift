//
//  BannerView.swift
//  Lodjinha
//
//  Created by Gilson Gil on 22/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import UIKit

import Cartography

final class BannerView: UIView {
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isPagingEnabled = true
    scrollView.delegate = self
    return scrollView
  }()

  private let contentView = UIView()

  private let pageControl = UIPageControl()

  private var widthConstraint: NSLayoutConstraint!

  private var imageUrls: [String] = []

  private var displayLink: CADisplayLink?

  private var linkTimestamp: CFTimeInterval?

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
  }

  private func addSubviews() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)
    addSubview(pageControl)
  }

  private func addConstraints() {
    constrain(self, scrollView, contentView, pageControl) { view, scrollView, contentView, pageControl in
      scrollView.edges == view.edges
      contentView.edges == scrollView.edges
      contentView.height == view.height
      widthConstraint = contentView.width == self.bounds.width

      pageControl.bottom == view.bottom
      pageControl.centerX == view.centerX
    }
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    displayLink = CADisplayLink(target: self, selector: #selector(displayNext))
    displayLink?.add(to: .current, forMode: .common)
    linkTimestamp = displayLink?.timestamp
  }
}

// MARK: - Public
extension BannerView {
  func setImageUrls(_ imageUrls: [String]) {
    layoutIfNeeded()
    self.imageUrls = imageUrls
    removeImageViews()
    insertImageViews(imageUrls: imageUrls)
    pageControl.numberOfPages = imageUrls.count
  }
}

// MARK: - Private
private extension BannerView {
  func removeImageViews() {
    subviews
      .filter { $0 is UIImageView }
      .forEach { $0.removeFromSuperview() }
  }

  func insertImageViews(imageUrls: [String]) {
    let size = self.bounds.size
    imageUrls.enumerated().forEach {
      let imageView = createImageView()
      imageView.imageUrl = $0.element
      self.contentView.addSubview(imageView)
      let originX = CGFloat($0.offset) * size.width
      constrain(self.contentView, imageView) { contentView, imageView in
        imageView.top == contentView.top
        imageView.left == contentView.left + originX
        imageView.width == size.width
        imageView.height == contentView.height
      }
    }
    widthConstraint.constant = size.width * CGFloat(imageUrls.count)
  }

  func createImageView() -> URLImageView {
    let imageView = URLImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }

  @objc
  func displayNext() {
    guard let linkTimestamp = linkTimestamp, linkTimestamp != 0 else {
      return self.linkTimestamp = displayLink?.timestamp
    }
    guard let timestamp = displayLink?.timestamp, linkTimestamp.distance(to: timestamp) > 5 else { return }
    let currentPage = pageControl.currentPage
    let pages = imageUrls.count
    if currentPage == pages - 1 {
      let rect = CGRect(origin: .zero, size: scrollView.bounds.size)
      scrollView.scrollRectToVisible(rect, animated: true)
    } else {
      let origin = CGPoint(x: CGFloat(currentPage + 1) * scrollView.bounds.width, y: 0)
      let rect = CGRect(origin: origin, size: scrollView.bounds.size)
      scrollView.scrollRectToVisible(rect, animated: true)
    }
    self.linkTimestamp = displayLink?.timestamp
  }

  func resetTimer() {
    linkTimestamp = displayLink?.timestamp
    displayLink?.isPaused = false
  }
}

// MARK: - UIScrollView Delegate
extension BannerView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x / scrollView.bounds.width + 0.5
    pageControl.currentPage = Int(page)
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    displayLink?.isPaused = true
  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    resetTimer()
  }
}
