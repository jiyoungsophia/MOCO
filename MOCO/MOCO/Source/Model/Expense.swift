//
//  Expense.swift
//  MOCO
//
//  Created by 지영 on 2021/11/24.
//

import Foundation
import RealmSwift

class Expense {
 /*
     date
     amount
     isOffline(bool)
     onlineMemo?
     place id? 
     _id
     year
     month
     */
    @Persisted var amount: Int
    @Persisted var regDate = Date()
    @Persisted var isOffline: Bool
    @Persisted var placeId: String? // offline
    @Persisted var memo: String? // online
    @Persisted var year: Int
    @Persisted var month: Int
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(amount: Int, regDate: Date, isOffline:year: Int, month: Int) {
        self.init()
        self.amount = amount
        self.regDate = regDate
        self.year = year
        self.month = month
    }
}
