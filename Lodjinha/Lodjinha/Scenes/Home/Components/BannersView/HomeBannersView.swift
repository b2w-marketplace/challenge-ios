//
//  HomeBannersView.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class HomeBannersView: UIView {

    private var banners: [Banner] = []
    
    var currentBanner = 0 {
        didSet {
            collectionView.scrollToItem(at: IndexPath(item: currentBanner, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentBanner
        }
    }
    
    private var collectionView: UICollectionView!
    private var pageControl: UIPageControl!
    private weak var bannersXIB: HomeBannersViewXIB!
    
    func updateBanners(banners: [Banner]) {
        self.banners = banners
        collectionView.reloadData()
        setupPageControl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    private func setupNib() {
        let nib = UINib(nibName: "HomeBannersView", bundle: Bundle(for: HomeBannersView.self))
        let xib = nib.instantiate(withOwner: nil, options: nil).first as! HomeBannersViewXIB
        xib.frame = bounds
        xib.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        insertSubview(xib, at: 0)
        bannersXIB = xib
        collectionView = bannersXIB.collectionView
        pageControl = bannersXIB.pageControll
        setupCollectionView()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.25
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.register(HomeBannerViewCell.self, forCellWithReuseIdentifier: "bannerCell")
    }
    
    private func setupPageControl() {
        pageControl.currentPage = currentBanner
        pageControl.numberOfPages = banners.count
    }
}

extension HomeBannersView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! HomeBannerViewCell
        cell.configure(banner: banners[indexPath.item])
        return cell
    }
    
}

extension HomeBannersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let index = currentIndexForOffset(offset: scrollView.contentOffset, inContentSize: scrollView.contentSize)
        currentBanner = index
    }
    
    private func currentIndexForOffset(offset: CGPoint, inContentSize contentSize: CGSize) -> Int {
        
        let flow = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        let cellWidth = (contentSize.width - ((CGFloat(banners.count) - 1) * flow.minimumLineSpacing)) / CGFloat(banners.count)
        let currentCellSpace: CGFloat = cellWidth * CGFloat(currentBanner + 1)
        let lowerBound = CGFloat(currentBanner) * cellWidth
        var index = currentBanner
        
        if offset.x < lowerBound  {
            if offset.x.distance(to: lowerBound) >= (currentCellSpace - lowerBound) / 5 {
                index = currentBanner == 0 ? 0 : currentBanner - 1
            }
            return index
        } else if (offset.x - lowerBound) < ((currentCellSpace - lowerBound) / 5) {
            return index
        } else {
            if index == banners.count - 1 {
                index = banners.count - 1
            } else {
                index += 1
            }
            return index
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = currentIndexForOffset(offset: scrollView.contentOffset, inContentSize: scrollView.contentSize)
        currentBanner = index
    }
    
}
