//
//  BannerViewModel.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 14/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation

protocol BannerViewModelProtocol: ListProtocol
{
    var list: ListBanner? { get }
    var listBannerDidChange: ((BannerViewModelProtocol) -> Void)? { get set }
}

class BannerViewModel: BannerViewModelProtocol
{
    var list: ListBanner?
    {
        didSet
        {
            self.listBannerDidChange?(self)
        }
    }
    
    var listBannerDidChange: ((BannerViewModelProtocol) -> Void)?
    
    required init()
    {
        list = ListBanner()
    }
    
    func numberOfRows() -> Int
    {
        return list?.banners.count ?? 0
    }
}

extension BannerViewModel
{
    func getElement(completion: @escaping (Error?) -> Void)
    {
        let url = GenerateURL.get(type: .banner)
        BannerManager.getBanners(withURL: url) { (banners, error) in
            if let list = banners
            {
                self.list = list
            }
            if let error = error
            {
                completion(error)
            }
        }
    }
}
