//
//  Number+Extensions.swift
//  MOCO
//
//  Created by 지영 on 2021/11/22.
//

import Foundation

extension NumberFormatter {
    static var defaultFormat: NumberFormatter {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format
    }
}


extension Int {
    var formatWithSeparator: String {
        return NumberFormatter.defaultFormat.string(for: self) ?? ""
    }
}
