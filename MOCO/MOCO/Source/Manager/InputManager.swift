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
    
    func calculateDday() -> Int {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko")

        //여기에 기입하지 않은 날짜는 1로 초기화가 된다
        let components = calendar.dateComponents([.year, .month], from: Date())

        //day를 기입하지 않아서 현재 달의 첫번쨰 날짜가 나오게 된다
        let startOfMonth = calendar.date(from: components)

        //이번 달의 마지막 날짜를 구해주기 위해서 다음달을 구한다 이것도 day를 넣어주지 않았기 때문에 1이 다음달의 1일이 나오게 된다
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth!)

        //위에 값에서 day값을 넣어주지 않았기 떄문에 1이 나오게 되므로 마지막 날을 알기 위해서 -1을 해준다
        let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)
                
        let dDay = calendar.dateComponents([.day], from: Date(), to: endOfMonth!)

        return dDay.day! + 1
    }
}
