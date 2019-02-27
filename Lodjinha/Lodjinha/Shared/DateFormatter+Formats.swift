//
//  DateFormatter+Formats.swift
//  Lodjinha
//
//  Created by Gilson Gil on 27/02/19.
//  Copyright © 2019 Gilson Gil. All rights reserved.
//

import Foundation

extension DateFormatter {
  static var displayDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.locale = Locale(identifier: "pt-BR")
    return dateFormatter
  }()
}
