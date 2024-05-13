//
//  SignWeightMode.swift
//  YeonBa
//
//  Created by jin on 4/15/24.
//

import Foundation
import UIKit

enum SignWeightMode: Int, CaseIterable {
    case thinBody
    case middleBody
    case littleFatBody
    case fatBody
    case empty
    
    var title: String? {
        switch self {
        case .thinBody:
            return "마른체형"
        case .middleBody:
            return "보통체형"
        case .littleFatBody:
            return "조금통통"
        case .fatBody:
            return "통통체형"
        case .empty:
            return nil
            
        }
    }
}
