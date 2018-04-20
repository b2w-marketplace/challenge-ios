//
//  AbstractRouter.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class AbstractRouter: NSObject {
    
    weak var rootViewController: UIViewController?
    
    required init(rootViewController: UIViewController?) {
        super.init()
        self.rootViewController = rootViewController
    }
    
    
    class func viewController(vc: UIViewController) -> UIViewController { fatalError() }
    
    class func viewController() -> UIViewController { fatalError() }
    
    class func tableViewController() -> UITableViewController { fatalError() }
    
    func onSessionError() {
        
    }
    
    func goBackView() {
        self.rootViewController!.navigationController!.popViewController(animated: true)
    }
    
    
    func goDismiss() {
        self.rootViewController!.dismiss(animated: true, completion: nil)
    }
}
