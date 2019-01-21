//
//  HTTPServices.swift
//  LodjinhaMarketPlace
//
//  Created by Elias Amigo on 20/01/19.
//  Copyright © 2019 Santa Rosa Digital. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class HTTPServices {
    
    private static let servicesURL = "https://alodjinha.herokuapp.com"
    
    static func requestBestSellers() {
        
        Alamofire.request("\(servicesURL)/produto/maisvendidos", method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    NotificationCenter.default.post(name: .ProductBestSellers, object: self, userInfo: [AnyHashable("resultSuccess"): true, AnyHashable("resultData"): resultData])
                case .failure(let error):
                    NotificationCenter.default.post(name: .ProductBestSellers, object: self, userInfo: [AnyHashable("resultSuccess"): false, AnyHashable("resultData"): resultData, AnyHashable("error") : error.localizedDescription])
                }
        }
    }
    
    static func requestProductList(from offset: Int?, limit quantity: Int?, category id: Int?) {
        
        var parameters = [String]()
        var request = ""
        
        if let _ = id, id! > 0 {
            parameters.append("categoriaId=\(id!)")
        }
        if let _ = quantity, quantity! > 0 {
            parameters.append("limit=\(quantity!)")
        }
        if let _ = offset, offset! > 0 {
            parameters.append("offset=\(offset!)")
        }
        
        for parameter in parameters {
            request += "\(request)\(parameter)&"
        }
        
        Alamofire.request("\(servicesURL)/produto?\(request)", method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    NotificationCenter.default.post(name: .ProductBestSellers, object: self, userInfo: [AnyHashable("resultSuccess"): true, AnyHashable("resultData"): resultData])
                case .failure(let error):
                    NotificationCenter.default.post(name: .ProductBestSellers, object: self, userInfo: [AnyHashable("resultSuccess"): false, AnyHashable("resultData"): resultData, AnyHashable("error") : error.localizedDescription])
                }
        }
    }
    
    static func requestProductDetail(_ id: Int) {
        
        guard id > 0 else {
            NotificationCenter.default.post(name: .ProductBestSellers, object: self, userInfo: [AnyHashable("resultSuccess"): false, AnyHashable("resultData"): "", AnyHashable("error") : ""])
            return
        }
        
        Alamofire.request("\(servicesURL)/produto/\(id)", method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    NotificationCenter.default.post(name: .ProductDetail, object: self, userInfo: [AnyHashable("resultSuccess"): true, AnyHashable("resultData"): resultData])
                case .failure(let error):
                    NotificationCenter.default.post(name: .ProductDetail, object: self, userInfo: [AnyHashable("resultSuccess"): false, AnyHashable("resultData"): resultData, AnyHashable("error") : error.localizedDescription])
                }
        }
    }
    
    static func reservationProduct(_ id: Int) {
        
        guard id > 0 else {
            NotificationCenter.default.post(name: .ProductBestSellers, object: self, userInfo: [AnyHashable("resultSuccess"): false, AnyHashable("resultData"): "", AnyHashable("error") : ""])
            return
        }
        
        Alamofire.request("\(servicesURL)/produto/\(id)", method: .post, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                
                var resultData = ""
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) { resultData = utf8Text }
                
                switch response.result {
                case .success:
                    NotificationCenter.default.post(name: .ProductReservation, object: self, userInfo: [AnyHashable("resultSuccess"): true, AnyHashable("resultData"): resultData])
                case .failure(let error):
                    NotificationCenter.default.post(name: .ProductReservation, object: self, userInfo: [AnyHashable("resultSuccess"): false, AnyHashable("resultData"): resultData, AnyHashable("error") : error.localizedDescription])
                }
        }
    }
}
