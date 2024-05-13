//
//  WhyMode.swift
//  YeonBa
//
//  Created by 김민솔 on 3/28/24.
//

import Foundation
import UIKit

enum WhyMode: Int, CaseIterable {
    case maner
    case fuck
    case badprofile
    case badchat
    case other
    case empty
    var title: String? {
       
        switch self {
        case .maner:
            return "비매너 사용자입니다."
        case .fuck:
            return "욕설을 사용합니다."
        case .badprofile:
            return "프로필 사진이 부적절합니다."
        case .badchat:
            return "부적절한 채팅을 보냅니다."
        case .other:
            return "기타 사유"
        case .empty:
            return nil
        }
    
        
    }
}
