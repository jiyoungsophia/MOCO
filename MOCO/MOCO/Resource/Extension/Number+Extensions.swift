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
        format.locale = Locale.current
        format.numberStyle = .decimal
        format.maximumFractionDigits = 0 // 허용하는 소수점 자리수
        return format
    }
}

//extension Int {
//    var formatWithSeparator: String {
//        return NumberFormatter.defaultFormat.string(for: self) ?? ""
//    }
//}
