//
//  SignLocationMode.swift
//  YeonBa
//
//  Created by jin on 4/15/24.
//

import Foundation
import UIKit

enum SignLocationMode: Int, CaseIterable {
    case seoul
    case gyeonggi
    case incheon
    case busan
    case daejeon
    case gwangju
    case daegu
    case ulsan
    case gangwon
    case chungbuk
    case chungnam
    case jeonbuk
    case jeonnam
    case gyeongbuk
    case gyeongnam
    case sejong
    case jeju
    case empty
    
    var title: String? {
        switch self {
        case .seoul:
            return "서울"
        case .gyeonggi:
            return "경기"
        case .incheon:
            return "인천"
        case .busan:
            return "부산"
        case .daejeon:
            return "대전"
        case .gwangju:
            return "광주"
        case .daegu:
            return "대구"
        case .ulsan:
            return "울산"
        case .gangwon:
            return "강원"
        case .chungbuk:
            return "충북"
        case .chungnam:
            return "충남"
        case .jeonbuk:
            return "전북"
        case .jeonnam:
            return "전남"
        case .gyeongbuk:
            return "경북"
        case .gyeongnam:
            return "경남"
        case .sejong:
            return "세종"
        case .jeju:
            return "제주"
        case .empty:
            return nil
        }
    }
}
