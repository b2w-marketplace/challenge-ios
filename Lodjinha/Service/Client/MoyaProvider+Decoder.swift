//
//  MoyaProvider+Decoder.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import Moya
import Gloss
import Result
import Moya_Gloss
import RxSwift

extension MoyaProvider {
    
    func moyaRequestArray<T:Gloss.JSONDecodable>(_ target:Target, type:T.Type) -> Observable<[T]> {
        return Observable.create({ o in
            let task = self.request(target, callbackQueue:nil, progress:nil) { result in
                switch result {
                case .success(let response):
                    do {
                        let model = try response.mapArray(T.self)
                        o.onNext(model)
                        o.onCompleted()
                    } catch {
                        o.onError(error)
                        o.onCompleted()
                    }
                    break;
                case .failure(let error):
                    o.onError(APIError.init(error, response: nil))
                    o.onCompleted()
                    break;
                }
            }
            return Disposables.create { task.cancel() }
        })
    }
    
    func moyaRequest<T:Gloss.JSONDecodable>(_ target:Target, type:T.Type) -> Observable<T> {
        return Observable.create({ o in
            
            let task = self.request(target, callbackQueue:nil, progress:nil) { result in
                switch result {
                case .success(let response):
                    do {
                        let model = try response.mapObject(T.self)
                        o.onNext(model)
                        o.onCompleted()
                    } catch {
                        o.onError(APIError.init(error, response: response))
                        o.onCompleted()
                    }
                    break;
                case .failure(let error):
                    o.onError(APIError.init(error, response: nil))
                    o.onCompleted()
                    break;
                }
            }
            
            return Disposables.create { task.cancel() }
            
        })
    }
    
    func moyaRequestBodylessResponse(_ target: Target) -> Observable<Bool> {
        return Observable.create({ o in
            let task = self.request(target, callbackQueue: nil, progress: nil) { result in
                switch result {
                case .success(let response):
                    
                    if !(200..<300).contains(response.statusCode) {
                        //error, how to map it now?
                        o.onError(APIError.init(result.error, response: response))
                        o.onCompleted()
                        return
                    }
                    
                    o.onNext(true)
                    o.onCompleted()
                    
                    break;
                case .failure(let error):
                    o.onError(APIError.init(result.error, response: nil))
                    o.onCompleted()
                    break;
                }
            }
            return Disposables.create { task.cancel() }
        })
    }
    
}

class APIError : Error {
    
    let error:Error?
    let response:Response?
    
    init(_ error:Error?, response:Response?) {
        self.error = error
        self.response = response
    }
}
