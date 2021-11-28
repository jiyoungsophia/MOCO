//
//  category.swift
//  MOCO
//
//  Created by 지영 on 2021/11/25.
//

import Foundation

//enum Category {
//    case MT1 //대형마트
//    case CS2 //편의점
//    case PS3 //어린이집, 유치원
//    case SC4 //학교
//    case AC5  //학원
//    case PK6 // 주차장
//    case OL7  //주유소,충전소
//    case SW8  //지하철역
//    case BK9  //은행
//    case CT1  //문화시설
//    case AG2  //중개업소
//    case PO3 //공공기관
//    case AT4 //관광명소
//    case AD5 //숙박
//    case FD6  //음식점
//    case CE7 //카페
//    case HP8  //병원
//    case PM9 //약국
//
//    func setCategory() -> String {
//        switch self {
//        case .MT1:
//            return "👛" //대형마트
//        case .CS2:
//            return"🍪" //편의점
//        case .PS3:
//            return"🧒" //어린이집, 유치원
//        case .SC4:
//            return"🎓" //학교
//        case .AC5:
//            return"📚" //학원
//        case .PK6:
//            return"🚗" // 주차장
//        case .OL7:
//            return"⛽️" //주유소,충전소
//        case .SW8:
//            return"🚆" //지하철역
//        case .BK9:
//            return"🏦" //은행
//        case .CT1:
//            return"🎫" //문화시설
//        case .AG2:
//            return"🏘" //중개업소
//        case .PO3:
//            return"🏢" //공공기관
//        case .AT4:
//            return"🎡" //관광명소
//        case .AD5:
//            return"🏨" //숙박
//        case .FD6:
//            return"🍚" //음식점
//        case .CE7:
//            return"☕️" //카페
//        case .HP8:
//            return"🏥" //병원
//        case .PM9:
//            return "💊" //약국
//
//        @unknown default:
//            return "💸"
//        }
//    }
//}

let CategoryDict: Dictionary<String, String> = [
    "MT1": "👛", "CS2": "🍪", "PS3": "🧒", "SC4": "🎓", "AC5": "📚",
    "PK6": "🚗", "OL7": "⛽️", "SW8": "🚆", "BK9": "🏦", "CT1": "🎫",
    "AG2": "🏘", "PO3": "🏢", "AT4": "🎡", "AD5": "🏨", "FD6": "🍚",
    "CE7": "☕️", "HP8": "🏥", "PM9": "💊", "0": "💸"
    ]


