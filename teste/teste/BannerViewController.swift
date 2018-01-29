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
import SwiftyJSON

class BannerViewController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    private var banners: Array<JSON>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBanners()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        self.pageControl.currentPage-=1;
        self.setupBanner()
    }
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.pageControl.currentPage+=1;
        self.setupBanner()
    }
    
    func getBanners() {
        Alamofire.request(APPURL.GetBanners, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                self.banners = jsonData["data"].arrayValue
                self.pageControl.numberOfPages = self.banners.count
                self.setupBanner()
                
                print("JSON: \(self.banners)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupBanner() {
        if let urlImagem = URL(string: self.banners[self.pageControl.currentPage]["urlImagem"].stringValue) {
            self.bannerImage.af_setImage(withURL: urlImagem)
        }
        
    }
}
