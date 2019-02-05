//
//  ApiClient.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class ApiSettings: NSObject {
    static let sharedInstance = ApiSettings()
    
    var baseURL: String!
    
    var version: String!
    var apiKey: String!
    var baseImageURL: String!
    
    override init() {
        super.init()
        
        self.loadAllItens()
    }
    
    func getApiSettingsItem(_ item :String) -> AnyObject
    {
        let filePath = Bundle.main.path(forResource: "ApiSettings", ofType: "plist")!
        let stylesheet : NSDictionary! = NSDictionary(contentsOfFile:filePath)
        
        return stylesheet.object(forKey: item)! as AnyObject
    }
    
    //MARK: - Settings of The Movie DB
    
    func loadAllItens() {
        self.version = (self.getApiSettingsItem("version") as! String)
        self.apiKey  = (self.getApiSettingsItem("apiKey") as! String)
        self.baseURL = (self.getApiSettingsItem("baseURL") as! String)
        self.baseImageURL = (self.getApiSettingsItem("baseImageURL") as! String)
    }
}
