//
//  HomeInteractor.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {
    var currentTask: URLSessionTask?
    
    func getBannerList(successHandler: @escaping (_ responseObject: Array<Banner>?) -> (), errorHandler: @escaping (_ errorObject: NSError?, _ isCancelled: Bool) -> ()){
        
        if self.currentTask == nil || self.currentTask?.state != .running{
//            let loading = LoadingPresenter()
//            loading.showLoading()
            
            self.currentTask = BannerClient().getBanner(successHandler: { bannerList in
                //loading.hideLoading()
                successHandler(bannerList)
            }) { error, isCancelled in
               // loading.hideLoading()
                errorHandler(error, isCancelled)
            }
        }
    }
}
