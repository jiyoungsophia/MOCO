//
//  InputManager.swift
//  MOCO
//
//  Created by 지영 on 2021/11/27.
//

import Foundation

final class InputManager {
    private init() {}
    static let shared = InputManager()
    
    func dateToYearMonth(date: Date) -> [Int] {
        
        var dateList: [Int] = []
        let date = Calendar.current.dateComponents(in: .current, from: date)
        
        if let year = date.year, let month = date.month {
            dateList = [year, month]
        }
        
        return dateList
    }
    
    func textToInt(text: String) -> Int {
        var amount: Int = 0
        if let value = Int(text.replacingOccurrences(of: ",", with: "")) {
            amount = value
        }
        return amount
    }
    
}
