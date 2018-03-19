//
//  Response.swift
//  Lodjinha
//
//  Created by Daniel Novio on 18/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

import Alamofire

class Configuration: NSObject {
    
    var headers: HTTPHeaders {
        var myHeaders : [String : String] = [:]

        myHeaders["Content-Type"] = contentType
        myHeaders["Authorization"] = "Basic dW1xdWFydG86bHB1Yzk2bmF3"
        
        return myHeaders
    }
    
//MARK: Lodjinha Config
    
    public var baseURL: String! {
        let configuration = configurationFile()
        
        #if RELEASE
            guard let url = configuration!["baseURL"] else {
                NSLog("Ooops! Didn't find baseURL on configuration file")
                
                return ""
            }
        #else
            guard let url = configuration!["debugURL"] else {
                NSLog("Ooops! Didn't find debugURL on configuration file")
                
                guard let url = configuration!["baseURL"] else {
                    NSLog("Ooops! Didn't find neither debugURL and baseURL on configuration file")
                    
                    return ""
                }
                
                return url as! String
            }
        #endif
        
        return url as! String
    }
    
    public var contentType: String! {
        let configuration = configurationFile()
        
        guard let content = configuration!["contentType"] else {
            NSLog("Didn't find contentType on configuration file")
            
            return ""
        }
        
        return content as! String
    }
    
    func configurationFile() -> NSDictionary? {
        guard let path = Bundle.main.path(forResource: "LodjinhaConfig", ofType: "plist") else {
            NSLog("Didn't find configuration file. Configuration variables need to be overwrited")
            
            return nil
        }
        
        let configuration = NSDictionary(contentsOfFile: path)
        
        return configuration
    }
}
