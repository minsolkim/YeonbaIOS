//
//  AnimalMode.swift
//  YeonBa
//
//  Created by jin on 4/10/24.
//

import Foundation
import UIKit

enum AnimalMode: Int, CaseIterable {
    case dog
    case cat
    case deer
    case cow
    case fox
    case bear
    case empty
    
    var title: String? {
       
        switch self {
        case .dog:
            return "강아지상"
        case .cat:
            return "고양이상"
        case .deer:
            return "사슴상"
        case .cow:
            return "황소상"
        case .fox:
            return "여우상"
        case .bear:
            return "곰상"
        case .empty:
            return nil
        }
        
    }
}
