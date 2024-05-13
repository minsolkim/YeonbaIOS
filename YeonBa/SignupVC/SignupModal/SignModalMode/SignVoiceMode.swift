//
//  SignVoiceMode.swift
//  YeonBa
//
//  Created by jin on 4/15/24.
//

import Foundation
import UIKit

enum SignVoiceMode: Int, CaseIterable {
    case high
    case middle
    case low
    case empty
    
    var title: String? {
       
        switch self {
        case .high:
            return "고음"
        case .middle:
            return "중음"
        case .low:
            return "저음"
        case .empty:
            return nil
        }
        
    }
}
