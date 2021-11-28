//
//  RealmManager.swift
//  MOCO
//
//  Created by 양지영 on 2021/11/26.
//

import Foundation
import Realm
import RealmSwift

enum placeStatus: String {
    case offline = "true"
    case online = "false"
    
    var description: Bool {
        switch self {
        case .offline:
            return true
        case .online:
            return false
        }
    }
}

class RealmManager {
    
    static let shared = RealmManager()
    
    private let localRealm = try! Realm()
    
    private init() {
        print(localRealm.configuration.fileURL)
    }
    
    //MARK: - Place
    func savePlace(place: Place) {
        try! localRealm.write {
            localRealm.add(place)
        }
    }
    
    func loadPlace(id: Int) -> [Place] {
        return Array(localRealm.objects(Place.self).filter("placeId == \(id)"))
    }
    
    func updatePlace(place: Place, longtitude: Double, latitude: Double) {
        try! localRealm.write({
            place.longtitude = longtitude
            place.latitude = latitude
            localRealm.add(place, update: .modified)
        })
    }
    
    func saveOnline() {
        let online = Place(placeId: 0, placeName: "온라인", categoryCode: "0", longtitude: 0, latitude: 0)
        savePlace(place: online)
    }
    
    //MARK: - Income
    func saveIncome(income: Income) {
        try! localRealm.write {
            localRealm.add(income)
        }
    }
    
    func loadIncome(year: Int, month: Int) -> [Income] {
        return Array(localRealm.objects(Income.self).filter("year == \(year) AND month == \(month)"))
    }
    
    func updateIncome(income: Income, amount: Int, regDate: Date) {
        try! localRealm.write({
            income.amount += amount
            income.regDate = regDate
            localRealm.add(income, update: .modified)
        })
    }
    
    //TODO: 달아야함 !!!
    func deleteIncome(id: ObjectId) {
        try! localRealm.write({
            guard let object = localRealm.object(ofType: Income.self, forPrimaryKey: id) else { return }
            localRealm.delete(object)
        })
    }
    
    //MARK: - Expense
    func saveExpense(expense: Expense) {
        try! localRealm.write {
            localRealm.add(expense)
        }
    }
    
    func loadExpense(year: Int, month: Int) -> [Expense] {
        return Array(localRealm.objects(Expense.self).filter("year == \(year) AND month == \(month)").sorted(byKeyPath: "regDate", ascending: false))
    }
    
    // year month 도 업데이트하는게 맞겟지,,?
    func updateExpense(expense: Expense, amount: Int, regDate: Date, isOffline: Bool, placeId: Int?, memo: String, year: Int, month: Int) {
        try! localRealm.write({
            expense.amount = amount
            expense.regDate = regDate
            expense.isOffline = isOffline
            expense.placeId = placeId
            expense.memo = memo
            expense.year = year
            expense.month = month
            localRealm.add(expense, update: .modified)
        })
    }
    
    func deleteExpense(id: ObjectId) {
        try! localRealm.write({
            guard let object = localRealm.object(ofType: Expense.self, forPrimaryKey: id) else { return }
            localRealm.delete(object)
        })
    }
    
}
