//
//  Product.swift
//  Challenge-ios
//
//  Created by Roberto L V Junior on 17/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Product {

	private let serverUrl = Urls.server.rawValue
	private let productUrl = Urls.product.rawValue
    private let productByIdUrl = Urls.productById.rawValue
    private let productTopUrl = Urls.productTop.rawValue

	var id: Int!
	var image: String!
	var description: String!
	var priceFrom: Double!
	var price: Double!
	var name: String!
    var category: Category!

	func getAll(onCompletion:@escaping ([Product],[Product])->()) {
		var products = [Product]()
        var moreProducts = [Product]()
		Alamofire.request(serverUrl+productUrl).responseJSON {
			let productList = JSON($0.result.value!)
			if let resData = productList["data"].arrayObject {
				let list = resData as! [[String:AnyObject]]
				for items in list {
					let product = Product()
					for (key, value) in items {
						switch (key) {
						case "id":
							product.id = value as! Int
						case "urlImagem":
							product.image = value as! String
						case "precoDe":
							product.priceFrom = value as! Double
						case "precoPor":
							product.price = value as! Double
						case "nome":
							product.name = value as! String
						case "descricao":
							product.description = value as! String
                        case "categoria":
                            self.getCategoryByArrayObject(value, onCompletion: { (categoryResult) in
                                product.category = categoryResult
                            })
						default: break
						}
					}
                    if products.count < 20 {
                        products.append(product)
                    } else {
                        moreProducts.append(product)
                    }
				}
				DispatchQueue.main.async( execute: {
					onCompletion(products,moreProducts)
				})
			}
		}
	}
    
    func getTopProducts(onCompletion:@escaping ([Product])->()) {
        var products = [Product]()
        Alamofire.request(serverUrl+productTopUrl).responseJSON {
            let productList = JSON($0.result.value!)
            if let resData = productList["data"].arrayObject {
                let list = resData as! [[String:AnyObject]]
                for items in list {
                    let product = Product()
                    for (key, value) in items {
                        switch (key) {
                        case "id":
                            product.id = value as! Int
                        case "urlImagem":
                            product.image = value as! String
                        case "precoDe":
                            product.priceFrom = value as! Double
                        case "precoPor":
                            product.price = value as! Double
                        case "nome":
                            product.name = value as! String
                        case "descricao":
                            product.description = value as! String
                        case "categoria":
                            self.getCategoryByArrayObject(value, onCompletion: { (categoryResult) in
                                product.category = categoryResult
                            })
                        default: break
                        }
                    }
                    products.append(product)
                }
                DispatchQueue.main.async( execute: {
                    onCompletion(products)
                })
            }
        }
    }
    
    func getCategoryByArrayObject(_ value: AnyObject, onCompletion:(Category)->()) {
        let category = Category()        
        let list = value as! [String:AnyObject]
            for (key, desc) in list {
                switch (key) {
                case "id":
                    category.id = desc as! Int
                case "urlImagem":
                    category.image = desc as! String
                case "descricao":
                    category.description = desc as! String
                default: break
                }
        }
        onCompletion(category)
    }
    
    func getProductsByCategoryId(categoryId: Int, onCompletion:@escaping ([Product],[Product])->()){
        var productsByCategory = [Product]()
        var moreProductsByCategory = [Product]()
        self.getAll { (products, more) in
            for product in products {
                if product.category.id.hashValue == categoryId {
                    productsByCategory.append(product)
                }
            }
            for moreProduct in more {
                if moreProduct.category.id.hashValue == categoryId {
                    moreProductsByCategory.append(moreProduct)
                }
            }
            onCompletion(productsByCategory,moreProductsByCategory)
        }
    }
    
    func preOrder(productId: Int, onCompletion:@escaping (Bool)->()) {
        Alamofire.request(serverUrl+productByIdUrl+String(productId), method: .post)
            .responseJSON { (response) in
                onCompletion(response.result.isSuccess)
        }
    }

	class func downloadImage(url: String, onCompletion:@escaping (UIImage)->()) {
		DispatchQueue.main.async {
			Alamofire.request(url)
				.responseData { response in
					if let data = response.result.value {
						onCompletion(UIImage(data: data)!)
					}
			}
		}
	}
}
