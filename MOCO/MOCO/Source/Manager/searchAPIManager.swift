//
//  SearchAPIManager.swift
//  MOCO
//
//  Created by 지영 on 2021/11/25.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchAPIManager {
    private init() {}
    static let shared = SearchAPIManager()
    
    func fetchData(query: String, longtitude: Double, latitude: Double, result: @escaping (Result<[Search], Error>) -> () ) {
        
        let header: HTTPHeaders = [
            "Authorization": "KakaoAK \(Constants.kakaoKey)"
        ]
        
        let params: [String : Any] = [
            "query" : query,
            "x" : longtitude,
            "y" : latitude,
            "page": 1,
            "size": 15
        ] 
        
        AF.request(Endpoint.searchURL,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString), headers: header).validate(statusCode: 200...500).responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data)

                        let searchList = json["documents"].arrayValue
                        let searchData: [Search] = searchList.map {
                            Search(id: $0["id"].intValue,
                                   placeName: $0["place_name"].stringValue,
                                   roadAddress: $0["road_address_name"].stringValue,
                                   categoryCode: $0["category_group_code"].stringValue,
                                   categoryName: $0["category_group_name"].stringValue,
                                   longtitude: $0["x"].doubleValue,
                                   latitude: $0["y"].doubleValue)
                        }
                      
                        result(.success(searchData))
                        
                    case .failure(let error):
                        result(.failure(error))
                    }
                   }
    }
}
