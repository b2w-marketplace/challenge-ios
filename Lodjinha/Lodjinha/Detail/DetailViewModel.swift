//
//  DetailViewModel.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import Foundation

class DetailRepository{
    private var api:NetworkManager = RestManager.get(Routes.produto.endpoint)
    private var offset:Int = 0
    private var limit:Int = 10
    private var categoriaId:Int = 0
    
    init(categoriaId:Int) {
        self.categoriaId = categoriaId
    }
    
    func getListById(fromStart:Bool = false, completionHandler:@escaping ([Produto]) -> Void){
        api = RestManager.get(Routes.produtoPorCategoria(offset: offset, limit: limit, categoriaId: categoriaId).endpoint)
        if fromStart{
            offset = 0
        }else{
            offset += 1
        }
       
        
        api.response { (result:ResultHelper<DataBestSeller>) in
            dump(result)
            switch result{
            case .error(let error):
                debugPrint(error)
                completionHandler([])
            case .success(let statusCode, let resultData):
                print(statusCode)
                if resultData.data.count == 0 {
                    return
                }
                completionHandler(resultData.data)
            }
            
        }
        
        
    }

}
class DetailViewModel{
    private var items = [BestSellerViewModel]()
    private var categoryId:Int
    private var repository:DetailRepository
    
    init(categoryId:Int) {
        self.categoryId = categoryId
        repository = DetailRepository(categoriaId: categoryId)
    }
    
    var numberOfItems :Int {
        return items.count
    }
    
    var listItems:[BestSellerViewModel]{
        return self.items
    }
    
    func loadItems(fromStart:Bool =  false ,completion :@escaping  ()->Void){
        if fromStart{
            self.items.removeAll()
        }
        repository.getListById(fromStart: fromStart) { (listOfItems) in
            self.items.append(contentsOf: listOfItems.map{BestSellerViewModel(model: $0)})
            completion()
        }
    }
    
    func getItemAtIndex(index:Int)->Produto{
        return self.items[index].model
    }
    
    

}
