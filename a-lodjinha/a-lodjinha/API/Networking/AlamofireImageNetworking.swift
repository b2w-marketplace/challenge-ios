//
//  AlamofireImageNETWORKING.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 19/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class AlamofireImageNetworking {
    
    init() {
        Alamofire.DataRequest.addAcceptableImageContentTypes(["image/jpg", "image/png", "image/jpeg"])
    }
    
    func requestImage(url: String,
                      success: @escaping (_ image: UIImage) -> (),
                      failure: @escaping (NetworkingError?) -> ()) {
        
        let imgView = UIImageView()
        
        if let urlRequest = URL(string: url) {
            
            imgView.af_setImage(withURL: urlRequest, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: true){ (response) in
                
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    let errorCode = error._code
                    if errorCode == -999 || errorCode == 0 {
                        let error = NetworkingError(errorCode: "\(errorCode)", errorMessage: response.result.error.debugDescription)
                        failure(error)
                    }
                }
            }
            
        }
    }
    
}
