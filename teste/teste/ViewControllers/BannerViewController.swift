//
//  BannerViewController.swift
//  teste
//
//  Created by Rodrigo Marangoni on 26/01/18.
//  Copyright © 2018 romarangoni. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class BannerViewController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    private var banners: Array<Banner> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl.numberOfPages = 0;
        self.getBanners()

        // Do any additional setup after loading the view.
    }

    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        if self.pageControl.numberOfPages > 0 {
            self.pageControl.currentPage-=1;
            self.setupBanner()
        }
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        if self.pageControl.numberOfPages > 0 {
            self.pageControl.currentPage+=1;
            self.setupBanner()
        }
    }
    
    @IBAction func clickBanner(_ sender: Any) {
        if self.pageControl.numberOfPages > 0 {
            if let url = URL(string: self.banners[self.pageControl.currentPage].linkUrl!) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func getBanners() {
        Alamofire.request(APPURL.GetBanners, method: .get).validate().responseObject { (response:DataResponse<BannerData>) in
            switch response.result {
            case .success(let value):
                self.banners.append(contentsOf: value.data!)
                self.pageControl.numberOfPages = self.banners.count
                self.setupBanner()
                
                print("JSON: \(self.banners)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupBanner() {
        if let urlImagem = URL(string: self.banners[self.pageControl.currentPage].urlImage!) {
            self.bannerImage.af_setImage(withURL: urlImagem)
        }
        
    }
}
