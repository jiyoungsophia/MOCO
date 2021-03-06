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
    
    func loadPlaceList(id: Int) -> [Place] {
        return Array(localRealm.objects(Place.self).filter("placeId == \(id)"))
    }
    
    func loadPlaceCode(id: Int) -> String {
        return localRealm.objects(Place.self).filter("placeId == \(id)").first?.categoryCode ?? ""
    }
    
    func loadPlaceData(id: Int) -> Place {
        return localRealm.objects(Place.self).filter("placeId == \(id)").first!
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
    
    //FIXME: 마이그레이션 후 정렬 수정(regDate: 등록시간, expenseDate: 지출날짜(기존 regDate))
    func loadExpense(year: Int, month: Int) -> [Expense] {
        return Array(localRealm.objects(Expense.self).filter("year == \(year) AND month == \(month)").sorted(byKeyPath: "regDate", ascending: false))
//        .sorted( by: [SortDescriptor(keyPath: "regDate", ascending: false), SortDescriptor(keyPath: "placeId", ascending: false)] ))
    }
    
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
    
    func loadOfflineExpense(year: Int, month: Int) -> [Expense] {
        return Array(localRealm.objects(Expense.self).filter("year == \(year) AND month == \(month) AND isOffline == true").sorted(byKeyPath: "regDate", ascending: false))
    }
    
    
}
