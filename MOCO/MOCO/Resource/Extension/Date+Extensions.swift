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
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "dateformat".localized()
        
        return formatter
    }
    
    static var defaultFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy. MM. dd"
        
        return formatter
    }
}
