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
//        formatter.locale = Locale(identifier: "en_US")
//        formatter.setLocalizedDateFormatFromTemplate("MMM ")
//
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.setLocalizedDateFormatFromTemplate("M월 ")

        formatter.date(from: "dateformat".localized())
        
        return formatter
    }
    
    static var defaultFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy. MM. dd"
        
        return formatter
    }
}
