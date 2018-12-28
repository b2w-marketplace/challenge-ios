//
//  Utils.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

public func inMainAsync(_ run: @escaping () -> Void) {
    DispatchQueue.main.async {
        run()
    }
}

public func inMainAsyncAfter(interval: DispatchTimeInterval, _ run: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: {
        run()
    })
}

public func moneyFormatter(_ valor: Double) -> String {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.decimalSeparator = ","
    formatter.groupingSeparator = "."
    return formatter.string(for: valor)!
}

public func footerPlaceholder(width: CGFloat) -> UIView {
    return UIView(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.leastNonzeroMagnitude))
}
