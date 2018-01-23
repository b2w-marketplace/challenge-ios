//
//  LodjinhaAPI.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import AlamofireImage
import Alamofire
import ObjectMapper

class LodjinhaAPI {
    
    //cria o get pegando as infomaçoes mapeando qualquer tipo de classe mappable
    static func get <T: Any>
        (_ type: T.Type,
         url: String,
         finish:@escaping () -> Void,
         success:@escaping (_ item: T) -> Void,
         fail:@escaping (_ error: Error,_ code:Int?) -> Void) -> Void where T:Mappable {
        Alamofire.request(url).responseObject { (response: DataResponse<T>) in
            print("GET ------ \(url) with status code \(response.response?.statusCode ?? 0)")
            if response.response?.statusCode == 404{
                finish()
            }else{
                switch response.result {
                case .success(let item):
                    print("Response from GET ---- \(String(describing: response.result.value))")
                    success(item)
                case .failure(let error):
                    print("ERROR GET ---- ", error)
                    fail(error, (response.response?.statusCode)!)
                }
            }
        }
    }
    
    
    // post para um endereço fora dos endpoints da BRQ
    static func post(_ url: String,
                        _ parameters: Parameters? = nil,
                        _ header: [String:String]? = nil,
                        success: @escaping (_ dict: [String:Any]) -> Void,
                        fail:@escaping (_ error: Error,_ codeError: Int?) ->Void){
        
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: header).responseJSON { (response:DataResponse<Any>) in
                            
                            print("POST ------ \(url) with status code \(response.response?.statusCode ?? 0)")
              
                            switch response.result {
                            case .success:
                                print("Response from POST ---- \(response.result.value ?? "nil")")
                                if let data = response.result.value as? [String : Any] {
                                    success(data)
                                }
                            case .failure(let error):
                                print("ERROR POST ---- ", error)
                                fail(error, (response.response?.statusCode)!)
                            }
        }
    }
    
    //get de imagens fora dos endpoints da brq
    static func getImage(url: String,
                         success: @escaping (_ img: Image) -> Void,
                         fail:@escaping (_ error: Error) ->Void){
        
        Alamofire.request(url).responseImage { response in
            switch response.result{
            case .success:
                print("Response from IMAGE ---- \(response.result.value)")
                if let img = response.result.value{
                    success(img)
                }
            case .failure(let error):
                print("ERROR POST ---- ", error)
                fail(error)
            }
        }
    }
}
