//
//  BannerTableViewCell.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 12/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    private enum CellIdentifiers {
        static let banner = "BannerCell"
    }

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!

    var banners: [BannerItem]?

    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        setupViews()
    }

    private func setupViews() {
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .WarmPurple

        collectionView?.isPagingEnabled = true

        collectionView.dataSource = self
        collectionView.delegate = self
        selectionStyle = .none

        collectionView.layer.masksToBounds = false
        collectionView.layer.shadowColor = UIColor.Dark.cgColor
        collectionView.layer.shadowOpacity = 0.6
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        collectionView.layer.shadowRadius = 2

        pageControl.layer.zPosition = 1
        pageControl.hidesForSinglePage = true
        pageControl.backgroundColor = .clear

    }

    func configure(with banners: [BannerItem]?) {
        self.banners = banners
        if banners != nil {
            pageControl.numberOfPages = banners?.count ?? 0
            pageControl.alpha = 1
            indicatorView.stopAnimating()
        } else {
            pageControl.numberOfPages = 0
            pageControl.alpha = 0
            indicatorView.startAnimating()
        }
        collectionView.reloadData()
    }
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

}

extension BannerTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.banner, for: indexPath) as! BannerCollectionViewCell
        if let banners = banners, banners.count > indexPath.row {
            cell.configure(with: banners[indexPath.row])
        } else {
            cell.configure(with: nil)
        }
        return cell
    }
}

extension BannerTableViewCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

}
