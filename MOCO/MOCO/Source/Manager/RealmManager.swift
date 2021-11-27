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
    
}
