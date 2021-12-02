//
//  Place.swift
//  MOCO
//
//  Created by 지영 on 2021/11/24.
//

import Foundation
import RealmSwift

class Place: Object {

    @Persisted var placeId: Int
    @Persisted var placeName: String
    @Persisted var categoryCode: String?
    @Persisted var longtitude: Double
    @Persisted var latitude: Double
        
    convenience init(placeId: Int, placeName: String, categoryCode: String?, longtitude: Double, latitude: Double){
        self.init()
        self.placeId = placeId
        self.placeName = placeName
        self.categoryCode = categoryCode
        self.longtitude = longtitude
        self.latitude = latitude
    }
   
    
    
}
