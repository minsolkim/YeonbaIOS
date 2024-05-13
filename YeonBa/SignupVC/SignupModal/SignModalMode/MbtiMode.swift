//
//  MbtiMode.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//

import Foundation
import UIKit

enum MbtiMode: Int, CaseIterable {
    case ISTJ
    case ISFJ
    case INFJ
    case INTJ
    case ISTP
    case ISFP
    case INFP
    case INTP
    case ESTP
    case ESFP
    case ENFP
    case ENTP
    case ESTJ
    case ESFJ
    case ENFJ
    case ENTJ
    case empty
    
    var title: String? {
       
        switch self {
        case .ISTJ:
            return "ISTJ"
        case .ISFJ:
            return "ISFJ"
        case .INFJ:
            return "INFJ"
        case .INTJ:
            return "INTJ"
        case .ISTP:
            return "ISTP"
        case .ISFP:
            return "ISFP"
        case .INFP:
            return "INFP"
        case .INTP:
            return "INTP"
        case .ESTP:
            return "ESTP"
        case .ESFP:
            return "ESFP"
        case .ENFP:
            return "ENFP"
        case .ENTP:
            return "ENTP"
        case .ESTJ:
            return "ESTJ"
        case .ESFJ:
            return "ESFJ"
        case .ENFJ:
            return "ENFJ"
        case .ENTJ:
            return "ENTJ"
        case .empty:
            return nil
            
        }
        
    }
}
