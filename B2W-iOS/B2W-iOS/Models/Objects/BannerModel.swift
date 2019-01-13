//
//  BannerModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import Foundation

public class BannerModel: ModelInterface {
    
    public var id: Int?
    public var urlImagem: String?
    public var linkUrl: String?

    public required init() { }
    
    public init(id: Int?, urlImagem: String?, linkUrl: String?) {
        self.id = id
        self.urlImagem = urlImagem
        self.linkUrl = linkUrl
    }
}
