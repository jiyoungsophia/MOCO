//
//  RealmManager.swift
//  MOCO
//
//  Created by 양지영 on 2021/11/26.
//

import Foundation
import Realm
import RealmSwift

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
    
    //MARK: - Income
    func saveIncome(income: Income) {
        try! localRealm.write {
            localRealm.add(income)
        }
    }
    
    func loadIncome(year: Int, month: Int) -> [Income] {
//        let query = localRealm.objects(Income.self).where {
//            ($0.year == year && $0.month == month)
//        }
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
    
}
