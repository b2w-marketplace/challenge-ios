//
//  BannerTableViewCell.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var banner: [Banner]?
    weak var delegate: BannerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        delegate = self
        registerCell()
    }
    
    private func registerCell() {
        let bannerNibName = UINib(nibName: BannerString.BannerCollectionViewCell, bundle: nil)
        collectionView.register(bannerNibName, forCellWithReuseIdentifier: BannerString.BannerCollectionCell)
    }
    
    private func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension BannerTableViewCell: BannerViewDelegate {
    func fetchBanner(banner: [Banner]) {
        DispatchQueue.main.async {
            self.banner = banner
            self.collectionView.reloadData()
        }
    }
}

extension BannerTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = banner?.count ?? 0
        return banner?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerString.BannerCollectionCell, for: indexPath) as? BannerCollectionViewCell else {
            return BannerCollectionViewCell()
        }
        cell.fill(dto: BannerCellDTO(image: banner?[indexPath.row].urlImagem ?? ""))
        hideLoading()
        return cell
    }
}

extension BannerTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width/1, height: self.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UICollectionViewDelegate
extension BannerTableViewCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
