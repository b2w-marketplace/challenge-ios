//
//  DateExtension.swift
//  Lodjinha-B2W
//
//  Created by Fernanda on 23/01/2018.
//  Copyright © 2018 Empresinha. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    func toFullDateString() -> String
    {
        //Get Short Time String
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "pt_BR")
        let timeString = formatter.string(from: self as Date)
        
        return timeString
    }
}
