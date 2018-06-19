//
//  Identifiable.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

public protocol Identifiable: class {
    
    static var identifier: String { get }
    static var bundle: Bundle { get }
    static var nibName: String { get }
}

extension Identifiable where Self: UIView {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    public static var nibName: String {
        return identifier
    }
    
}

extension Identifiable where Self: UIViewController {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    public static var nibName: String {
        return identifier
    }
}
