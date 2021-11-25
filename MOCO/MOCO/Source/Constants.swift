//
//  Constants.swift
//  MOCO
//
//  Created by 지영 on 2021/11/25.
//

import Foundation

struct Endpoint {
    static let searchURL = "https://dapi.kakao.com/v2/local/search/keyword.json"
}

struct Constants {
    static var kakaoKey: String {
        (Bundle.main.infoDictionary?["KAKAO_API_KEY"] as? String) ?? ""
    }
}
