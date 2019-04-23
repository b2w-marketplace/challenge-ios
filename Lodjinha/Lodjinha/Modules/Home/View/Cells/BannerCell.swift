//
//  BannerCell.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import AlamofireImage

final class BannerCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var scrollViewBanners: UIScrollView!
    
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var bannerList: [Banner] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAccessibilityIdentifiers()
        applyStyle()
    }

    private func setupAccessibilityIdentifiers() {
        scrollViewBanners.accessibilityIdentifier = "scrollViewBanners"
        
        pageControl.accessibilityIdentifier = "pageControl"
    }
    
    private func applyStyle() {
        Style.apply(onShadow: scrollViewBanners)
    }
    
    private func setupSlides() {
        for i in 0 ..< bannerList.count {
            let imageView = UIImageView()
            imageView.tag = i
            if let url = URL(string: bannerList[i].urlImagem) {
                imageView.af_setImage(withURL: url)
            }
            imageView.frame = CGRect(x: scrollViewBanners.frame.width * CGFloat(i),
                                     y: 0,
                                     width: scrollViewBanners.frame.width,
                                     height: scrollViewBanners.frame.height)
            scrollViewBanners.addSubview(imageView)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(gesture:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        bringSubview(toFront: pageControl)
        pageControl.numberOfPages = bannerList.count
        pageControl.currentPage = 0
        scrollViewBanners.delegate = self
        scrollViewBanners.contentSize = CGSize(width: frame.width * CGFloat(bannerList.count),
                                               height: 0)
        scrollViewBanners.isPagingEnabled = true
        pageControl.addTarget(self, action: #selector(changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @objc private func handleTapGesture(gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view,
            let url = URL(string: bannerList[imageView.tag].linkUrl) else {
            return
        }
        UIApplication.shared.openURL(url)
    }
    
    @objc private func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollViewBanners.frame.size.width
        scrollViewBanners.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func setup(bannerList: [Banner]) {
        self.bannerList = bannerList
        setupSlides()
    }
    
}

extension BannerCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}
