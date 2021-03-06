//
//  Income.swift
//  MOCO
//
//  Created by 지영 on 2021/11/24.
//

import Foundation
import RealmSwift

class Income: Object {
    @Persisted var amount: Int
    @Persisted var regDate = Date()
    @Persisted var year: Int
    @Persisted var month: Int
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(amount: Int, regDate: Date, year: Int, month: Int) {
        self.init()
        self.amount = amount
        self.regDate = regDate
        self.year = year
        self.month = month
    }
}

