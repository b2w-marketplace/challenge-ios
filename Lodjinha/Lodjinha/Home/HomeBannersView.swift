//
//  HomeBannersView.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class HomeBannersView: UIView {

    private(set) var bannersCount: Int = 0
    var currentBanner = 0 {
        didSet {
            collectionView.scrollToItem(at: IndexPath(item: currentBanner, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    var collectionView: UICollectionView!
    weak var bannersXIB: HomeBannersViewXIB!
    
    func updateBanners(banners: [String]) {
        bannersCount = banners.count
        collectionView.reloadData()
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
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "bannerCell")
    }
    let colors: [UIColor] = [.red, .green, .blue]
}

extension HomeBannersView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
}

extension HomeBannersView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(scrollView.contentOffset)
        let index = currentIndexForOffset(offset: scrollView.contentOffset, inContentSize: scrollView.contentSize)
        currentBanner = index
    }
    
    private func currentIndexForOffset(offset: CGPoint, inContentSize contentSize: CGSize) -> Int {
        
        let flow = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        let cellWidth = (contentSize.width - ((CGFloat(bannersCount) - 1) * flow.minimumLineSpacing)) / CGFloat(bannersCount)
        let currentCellSpace: CGFloat = cellWidth * CGFloat(currentBanner + 1)
        let lowerBound = CGFloat(currentBanner) * cellWidth
        var index = currentBanner
        
        if offset.x < lowerBound  {
            if offset.x.distance(to: lowerBound) >= (currentCellSpace - lowerBound) / 5 {
                index = currentBanner == 0 ? 0 : currentBanner - 1
            }
            return index
        } else if offset.x < ((currentCellSpace - lowerBound) / 5) {
            return index
        } else {
            if index == bannersCount - 1 {
                index = bannersCount - 1
            } else {
                index += 1
            }
            return index
        }
        
    }
    
}
