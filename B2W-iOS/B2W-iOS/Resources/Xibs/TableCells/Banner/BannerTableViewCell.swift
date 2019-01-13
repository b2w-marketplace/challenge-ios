//
//  BannerTableViewCell.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit
import FSPagerView

protocol BannerCellDelegate: class {
    func didSelect(banner: BannerModel)
}

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerView: FSPagerView!
    @IBOutlet weak var pageControl: FSPageControl!
    
    weak var delegate: BannerCellDelegate?
    fileprivate var dataSource: [BannerModel] = [] {
        didSet {
            pageControl.numberOfPages = dataSource.count
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    final fileprivate func setup() {        
        pageControl.interitemSpacing = 15.0
        pageControl.itemSpacing = 10.0
        pageControl.hidesForSinglePage = true
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(UIColor.white, for: .selected)
        pageControl.setFillColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        pageControl.setStrokeColor(UIColor.lightGray, for: .normal)
        pageControl.setStrokeColor(UIColor.lightGray, for: .selected)
        pageControl.backgroundColor = UIColor.clear
        
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.isInfinite = true
        bannerView.automaticSlidingInterval = 5
        bannerView.isAccessibilityElement = false
        registerCells()
    }
    
    final fileprivate func clean() {
        dataSource.removeAll()
        bannerView.reloadData()
    }
    
    final fileprivate func registerCells() {
        bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

//MARK: Public methods
extension BannerTableViewCell {
    public func constructWith(banners: [BannerModel], delegate: BannerCellDelegate?) {
        dataSource = banners
        bannerView.reloadData()
        self.delegate = delegate
    }
}

//MARK: FSPagerView DataSource & Delegate
extension BannerTableViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return dataSource.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let model = dataSource[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.setImageFrom(url: model.urlImagem)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.clipsToBounds = true
        cell.accessibilityIdentifier = "FSPageViewCell\(index)"
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        
        let model = dataSource[index]
        delegate?.didSelect(banner: model)
    }
 
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        pageControl.currentPage = index
    }
}
