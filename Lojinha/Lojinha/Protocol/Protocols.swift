//
//  Protocols.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol VisibleView
{
    func isView(hide: Bool)
}

protocol ListControl: class
{
    func parseJSON(arrayJson: [JSON])
}


protocol InitializerProtocol: class
{
    init()
}

protocol Countable: class
{
    func numberOfRows() -> Int
}

protocol RequestElement: class
{
    func getElement(completion: @escaping(Error?) -> Void)
}

protocol RequestElementURL: class
{
    func getElement(withURL url: String, completion: @escaping(Error?) -> Void)
}


protocol SingleElement: InitializerProtocol, RequestElementURL
{
    
}

protocol ListProtocol: InitializerProtocol, Countable, RequestElement
{
    
}

protocol ListParamURLProtocol: InitializerProtocol, Countable, RequestElementURL
{
    
}
