//
//  Date+Extensions.swift
//  MOCO
//
//  Created by 지영 on 2021/11/21.
//

import Foundation

extension DateFormatter {
    static var monthFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMM ")

        formatter.locale = Locale(identifier: "ko_KR")
        formatter.setLocalizedDateFormatFromTemplate("M월 ")

        return formatter
    }
}
