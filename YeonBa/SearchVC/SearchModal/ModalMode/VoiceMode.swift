//
//  VoiceMode.swift
//  YeonBa
//
//  Created by 김민솔 on 3/30/24.
//

import Foundation
import UIKit

enum VoiceMode: Int, CaseIterable {
    case high
    case middle
    case low
    case allLike
    
    var title: String {
       
        switch self {
        case .high:
            return "고음"
        case .middle:
            return "중음"
        case .low:
            return "저음"
        case .allLike:
            return "다 좋아요"
            
        }
        
    }
}
