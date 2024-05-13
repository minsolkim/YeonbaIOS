//
//  DeclareMode.swift
//  YeonBa
//
//  Created by 김민솔 on 3/28/24.
//

import Foundation
import UIKit

enum DeclareMode: Int, CaseIterable {
    case declare
    case cut
    
    var title: NSAttributedString {
        let attributes: [NSAttributedString.Key: Any]
        let titleString: String
        
        switch self {
        case .declare:
            titleString = "신고하기"
            attributes = [.foregroundColor: UIColor.red]
        case .cut:
            titleString = "차단하기"
            attributes = [:] 
        }
        
        return NSAttributedString(string: titleString, attributes: attributes)
    }
}
