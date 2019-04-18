//
//  Date+Format.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

extension Date {
    
    private enum Constants {
        static let dayMonthYearFormat = "dd 'de' MMMM 'de' yyyy";
    }
    
    func stringDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dayMonthYearFormat
        return formatter.string(from: self)
    }
    
}
